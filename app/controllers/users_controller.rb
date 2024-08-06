class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def index
     @user = current_user
     @books= @user.books
     @book = Book.new
     @users= User.all
  end

  def create
     @user = User.new(user_params)
      @user.user_id = current_user.id
    if @user.save
    flash[:notice] = "Welcome! You have signed up successfully."
    redirect_to user_path(@user.id)
    else
      render :index
    end
  end

  def show
     @user = User.find(params[:id])
     @books= @user.books
     @book = Book.new
     @users= User.all
  end

  def edit

  end

  def update
    @user.update(user_params)
    if @user.save
     flash[:notice] = "You have updated user successfully."
     redirect_to user_path(@user.id)
    else
      @users = User.all
      render :edit
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :introduction)
  end

   def is_matching_login_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
    redirect_to user_path(current_user)
    end
   end
end
