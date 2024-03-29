class UsersController < ApplicationController
  
  before_action :authenticate_user!, only: [:index, :show, :edit, :update]
  
  def index
    @users = User.all
    @user = User.find(current_user.id)
    @book = Book.new
  end
  
  def show
    @users = User.all
    # @books = @user.books.page(params[:page]).reverse_order
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end
  
  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
    
    @user = User.find(params[:id])
  end
  
  def update
    # user = User.find(params[:id])
    # unless user.id == current_user.id
    #   redirect_to books_path
    # end
  
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  private
  
   def user_params
    params.require(:user).permit(:profile_image, :name, :introduction)
   end
  end
