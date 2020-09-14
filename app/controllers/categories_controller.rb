class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]



  def index
    authorize Item,:create?, policy_class:ItemPolicy
    @categories = Category.all
    @categorizations=Categorization.get_assigned_categories
  end


  def show
    authorize Item,:create?, policy_class:ItemPolicy
  end


  def new
    authorize Item,:create?, policy_class:ItemPolicy
    @category = Category.new
  end


  def edit
    authorize Item,:create?, policy_class:ItemPolicy
  end


  def create
    authorize Item,:create?, policy_class:ItemPolicy
    @category = Category.new(category_params)
    respond_to do |format|
      if !@category.alreadyexist?
        if @category.save
          format.html { redirect_to @category, notice: 'Category was successfully created.' }
          format.json { render :show, status: :created, location: @category }
        else
          format.html { render :new,notice: 'Unknown error occured.' }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new,notice: 'Category already exists' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    authorize Item,:create?, policy_class:ItemPolicy
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    authorize Item,:create?, policy_class:ItemPolicy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_category
      @category = Category.find(params[:id])
    end



    def category_params
      params.require(:category).permit(:name)
    end
end
