class MessagesController < ApplicationController
  def index
    @people = User.find(current_user.received_messages.pluck(:sender_id).uniq)
  end

  def new
  end

  def show
    @messages = current_user.interaction_with(params[:id]) 
    @message = Message.new
  end
end
