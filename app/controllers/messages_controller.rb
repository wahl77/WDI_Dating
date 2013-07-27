class MessagesController < ApplicationController
  def index
    @people = current_user.received_messages.joins(:sender).select("messages.*, users.username as user_name, users.id as user_id")
  end

  def new
  end

  def show
    @messages 
  end
end
