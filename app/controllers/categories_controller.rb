class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authorization


  def index
    @categories = Category.all
    @categorizations=Categorization.get_assigned_categories
  end


  def show

  end


  def new
    @category = Category.new
  end


  def edit
  end


  def create
    @category = Category.new(category_params)
    if !@category.alreadyexist?
        if @category.save
          respond_to do |format|
            format.html { redirect_to @category, notice: 'Category was successfully created.' }
            format.json { render :show, status: :created, location: @category }
          end
        else
          respond_to do |format|
            format.html { render :new,notice: 'Unknown error occured.' }
            format.json { render json: @category.errors, status: :unprocessable_entity }
          end
        end
    else
        respond_to do |format|
          format.html { render :new,notice: 'Category already exists' }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
    end

  end


  def update
    category=@category.update(category_params)
    if category
      respond_to do |format|
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end

  end


  def destroy
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
