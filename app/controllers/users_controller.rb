class UsersController < ApplicationController

  skip_before_filter :require_login, only:[:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "User Created, go an sign in"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:user])
  end

  def update
    @user = User.find(params[:user])
    if (@user.update_attributes(params[:user]))
      redirect_to user_path(@user)
    else
      render :edit
    end
      
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  # Profile page
  def show
    @user = User.find(params[:id])
  end

  def index
  end
end
