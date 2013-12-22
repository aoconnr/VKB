class TypesController<ApplicationController

  def index
    @types = Type.all
    render
  end

  def show
    @type = Type.find(params[:id])
    render
  end

  def new
    @type = Type.new
    @categories = Category.all
  end

  def create
    @type = Type.new(params[:type])
    if @type.save
      redirect_to types_path, notice: 'type was successfully created.'
    else
      render action: "new"
    end
  end

  def edit
    @type = Type.find(params[:id])
    @categories = Category.all
  end

  def update
    @type = Type.find(params[:id])
    if @type.update_attributes(params[:type])
      redirect_to types_path, notice: 'type was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @type = Type.find(params[:id])
    @type.destroy
    redirect_to types_path, notice: "type deleted"
  end
end