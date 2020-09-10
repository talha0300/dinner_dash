class HomeController < ApplicationController
  before_action :authenticate_user!,only: [:show]
  def index

  end
  def show
    authorize :home, :show?
    @user =User.find(params[:id])
  end

  def record_not_found

  end
end
