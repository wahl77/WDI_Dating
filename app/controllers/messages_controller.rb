class MessagesController < ApplicationController
  def index
    @people = User.find(current_user.received_messages.pluck(:sender_id).uniq)
  end

  def new
  end

  def create
    message = Message.new(content: params[:message][:content])
    message.sender = current_user
    message.receiver = User.find(params[:message][:receiver])
    if message.save
      redirect_to message_path(params[:message][:receiver])
    else
      render :new
    end
  end

  def show
    @corresponder  = User.find(params[:id])
    @messages = current_user.interaction_with(@corresponder) 
    @message = Message.new
  end
end
