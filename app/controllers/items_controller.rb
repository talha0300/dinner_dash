class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy,:toggle_retire]

  def index

    @items=Item.get_items(get_filter)
    @categories=Category.get_categories(get_filter)

  end

  def show
    @item=Item.find_by(id:params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item=Item.new(item_params)
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


  def toggle_retire
    authorize @item,:update?
    if params[:type]==="retired"
      @item.update(retird:false)
      redirect_to items_path,:flash => { :success => "Successfully UnRetired an item" }
    else
      @item.update(retird:true)
      redirect_to items_path,:flash => { :success => "Successfully retired an item" }
    end

  end


  private
    def item_params
      params.require(:item).permit(:title,:description,:price,:image)
    end
    def set_item
      @item = Item.find_by(id:params[:id])
    end
    def get_filter
      if params[:Category]
        params[:Category][:name]
      else
        params[:Category]
      end

    end
end
