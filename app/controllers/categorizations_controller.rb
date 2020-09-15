class CategorizationsController < ApplicationController
  before_action :set_data, only: [:new]
  before_action :set_categorization,only: [:destroy]
  add_flash_types :error,:warning
  before_action :authorization


  def index
    @categorizations=Categorization.get_assigned_categories
  end



  def new
    @categorization=Categorization.new
  end

  def create
    item=Item.find_by(title:params[:categorization][:item])
    category=Category.find_by(name:params[:categorization][:category])
    if item && category

      if Categorization.assign_category(item,category)
        redirect_to new_categorization_path, flash:{ success:"Successfully assigned category to item" }
      else
        redirect_to new_categorization_path, :error => "Error: may be category already assigned to item"
      end
    else
      redirect_to new_categorization_path, :flash => { :error => "Category or Item not found" }
    end
  end

  def destroy
    session[:return_to] ||= request.referer
    if @categorization.destroy
      redirect_to session.delete(:return_to),:flash => { :success => "Successfully unassigned category to item" }
    else
      redirect_to session.delete(:return_to),:flash => { :success => "Failed to unassign category to item" }
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
