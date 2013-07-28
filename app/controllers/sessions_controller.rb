class SessionsController < ApplicationController

  skip_before_filter :require_login, only:[:new, :create]

  def new
  end

  def create
    user = login(params[:username], params[:password])
    if user
      respond_to do |format|
        format.html { redirect_to user_path(user), notice: "Logged in" }
        format.js { render layout: false }
      end
    else
      redirect_to root_path, alert: "Email or password invalid"
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "Logged out"
  end
end
