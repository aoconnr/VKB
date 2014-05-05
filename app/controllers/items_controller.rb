class ItemsController<ApplicationController

  http_basic_authenticate_with name: "admin", password: "password", :except => [:index, :show, :download]

  def index
    @items = Item.all
    render
  end

  def show
    @item = Item.find(params[:id])
    render
  end

  def new
    @item = Item.new
    @categories = Category.all
    @types = Type.all
  end

  def create
    @item = Item.new(params[:item])
    @item.price = params[:item][:price].to_f * 100
    if @item.save
      redirect_to items_path, notice: 'Item was successfully created.'
    else
      @item.price = params[:item][:price]
      render action: "new", notice: 'create failed'
    end
  end

  def edit
    @item = Item.find(params[:id])
    @categories = Category.all
    @types = Type.all
  end

  def update
    puts params.inspect
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item])
      redirect_to items_path, notice: 'Item was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path, notice: "item deleted"
  end

  def download
    @item = Item.find(params[:id])
    if params[:basename].to_s.include? "thumb" 
      path = "#{Rails.root}/uploads/#{@item.id}/thumb_#{File.basename(@item.image.url)}"
    else
      path = "#{Rails.root}/uploads/#{@item.id}/#{File.basename(@item.image.url)}"
    end
    send_file path, :x_sendfile=>true
  end
end