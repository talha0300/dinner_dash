class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items=Item.all
  end

  def show
    @item=Item.find_by(id:params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item=Item.new(item_params)
    debugger
    authorize @item
    if @item.save
      redirect_to root_path
    else
      render new_item_path
    end
  end

  def edit
  end


  def update
    authorize @item
    if @item.update(item_params)
      redirect_to @item
    else
      render "edit"
    end
  end

  def destroy
    if @item.destroy
      redirect_to items_path
    end
  end

  private
    def item_params
      params.require(:item).permit(:title,:description,:price,:image)
    end
    def set_item
      @item = Item.find_by(id:params[:id])
    end
end
