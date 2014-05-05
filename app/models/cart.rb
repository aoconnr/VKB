class Cart < ActiveRecord::Base
  attr_accessible :id, :purchased_at
  has_many :line_items
  # has_one :order
  
  def total_price
    # convert to array so it doesn't try to do sum on database directly
    line_items.to_a.sum(&:total_cost)
  end

  # def paypal_url(return_url)
  # values = {
  #   :business => 'aoconnor@gmail.com',
  #   :cmd => '_cart',
  #   :upload => 1,
  #   :return => return_url,
  #   :invoice => id
  # }
  # line_items.each_with_index do |item, index|
  #   values.merge!({
  #     "amount_#{index+1}" => item.unit_price,
  #     "item_name_#{index+1}" => item.item.name,
  #     "item_number_#{index+1}" => item.id,
  #     "quantity_#{index+1}" => item.quantity
  #   })
  # end
  # "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query

  def paypal_encrypted(return_url, notify_url)
    values = {
      :business => 'aoconnor@gmail.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => id,
      :notify_url => notify_url,
      :cert_id => "WZU6LQ5EM9LV8"
    }

    line_items.each_with_index do |item, index|
      values.merge!({
        "amount_#{index+1}" => item.cost,
        "item_name_#{index+1}" => item.item.name,
        "item_number_#{index+1}" => item.id,
        "quantity_#{index+1}" => item.quantity
      })
    end

    encrypt_for_paypal(values)
  end

  PAYPAL_CERT_PEM = File.read("#{Rails.root}/certs/paypal_cert.pem")
  APP_CERT_PEM = File.read("#{Rails.root}/certs/app_cert.pem")
  APP_KEY_PEM = File.read("#{Rails.root}/certs/app_key.pem")

  def encrypt_for_paypal(values)
    signed = OpenSSL::PKCS7::sign(OpenSSL::X509::Certificate.new(APP_CERT_PEM), OpenSSL::PKey::RSA.new(APP_KEY_PEM, ''), values.map { |k, v| "#{k}=#{v}" }.join("\n"), [], OpenSSL::PKCS7::BINARY)
    OpenSSL::PKCS7::encrypt([OpenSSL::X509::Certificate.new(PAYPAL_CERT_PEM)], signed.to_der, OpenSSL::Cipher::Cipher::new("DES3"), OpenSSL::PKCS7::BINARY).to_s.gsub("\n", "")
  end
end