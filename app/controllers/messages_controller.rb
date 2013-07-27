class MessagesController < ApplicationController
  load_and_authorize_resource

  def index
    @people = User.find(current_user.received_messages.pluck(:sender_id).uniq)
  end


  def create
    binding.pry
    message = Message.new(content: params[:message][:content])
    message.sender = current_user
    message.receiver = User.find(params[:message][:receiver]).first
    if message.save
      redirect_to message_path(params[:message][:receiver].to_i)
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
