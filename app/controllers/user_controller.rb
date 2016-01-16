class UserController < ApplicationController
  before_action :find_user , only: [:edit,:update]
  def index

  end

  def new
  end

  def create

    @user = User.new
    @user.name = params[:name]
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    @user.identity = 2
    @user.save

    redirect_to '/book/index'

  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to '/book/index'
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:password,:password_confirmation)
  end

  def find_user
    @user = User.find(current_user.id)
  end

end
