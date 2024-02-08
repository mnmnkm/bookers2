class UsersController < ApplicationController
  
  def index
    @users = User.all
    @book = Book.new
  end
  
  def show
    # @users = User.all
    # @user = User.find(params[:id])
    # @books = @user.books.page(params[:page]).reverse_order
    @user = User.find(params[:id])
    @books = @user.books
  end
  
  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to books_path
    end
    
    @user = User.find(params[:id])
  end
  
  def update
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to books_path
    end
  
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
