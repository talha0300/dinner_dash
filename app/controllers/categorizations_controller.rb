class CategorizationsController < ApplicationController
  before_action :set_data, only: [:new]
  before_action :set_categorization,only: [:destroy]
  add_flash_types :error,:warning


  def index
    @categorizations=Categorization.joins(:category,:item).order("title DESC").pluck(:id,:name,:title)
  end



  def new
    @categorization=Categorization.new

  end

  def create
    item=Item.find_by(title:params[:categorization][:item])
    category=Category.find_by(name:params[:categorization][:category])
    if item && category

      if Categorization.assign_category(item,category)
        redirect_to new_categorization_path, :flash => { :success => "Successfully assigned category to item" }
      else
        redirect_to new_categorization_path, :flash => { :error => "Error: may be category already assigned to item" }
      end
    else
      redirect_to new_categorization_path, :flash => { :error => "Category or Item not found" }
    end
  end

  def destroy

    if @categorization.destroy
      redirect_to categorizations_path,:flash => { :success => "Successfully unassigned category to item" }
    else
      redirect_to categorizations_path,:flash => { :success => "Failed to unassign category to item" }
    end
  end

  private

    def set_categorization
      @categorization = Categorization.find(params[:id])
    end
    def set_data
      @items=Item.all.pluck(:title)
      @categories=Category.all.pluck(:name)
    end

end
