class SessionsController < ApplicationController

  skip_before_filter :require_login, only:[:new, :create]

  def new
  end

  def create
    user = login(params[:username], params[:password])
    if user
      redirect_to user_path(user), notice: "Logged in"
    else
      redirect_to root_path, alert: "Email or password invalid"
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "Logged out"
  end
end
