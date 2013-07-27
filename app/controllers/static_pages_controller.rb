class StaticPagesController < ApplicationController
  skip_before_filter :require_login, only:[:index]
  def index
    @user = User.new
  end
end
