class UsersController < ApplicationController

  skip_before_filter :require_login, only:[:new, :create]
  load_and_authorize_resource

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
    @user = User.find(params[:id])
    @user.build_profile_pic if @user.profile_pic.nil?
  end

  def update
    #params[:user][:interested_in_male] = params[:user][:interested_in_male] == true
    @user = User.find(params[:id])
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
