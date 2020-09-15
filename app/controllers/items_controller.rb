class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy,:toggle_retire]

  def index

    @items=Item.get_items(get_filter)
    @categories=Category.get_categories(get_filter)

  end

  def show
    @item=Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item=Item.new(item_params)
    authorize @item
    if @item.save
      redirect_to @item
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
    authorize @item
    if @item.destroy
      redirect_to items_path
    end
  end


  def toggle_retire
    authorize @item,:update?
    if @item.update(retired:!@item.retired)
      redirect_to items_path,:flash => { :success => "Successfull changed status of the item" }
    else
      redirect_to items_path,:flash => { :error => "Operation failed" }
    end
  end


  private
    def item_params
      params.require(:item).permit(:title,:description,:price,:image)
    end
    def set_item
      @item = Item.find(params[:id])
    end
    def get_filter
      if params[:Category]
        params[:Category][:name]
      else
        params[:Category]
      end

    end
end
