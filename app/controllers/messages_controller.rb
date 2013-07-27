class MessagesController < ApplicationController
  #load_and_authorize_resource#, only:[:index]

  def index
    @people = User.find(current_user.received_messages.pluck(:sender_id).uniq)
  end


  def create
    @message = Message.new(content: params[:message][:content])
    @message.sender = current_user
    @message.receiver = User.find(params[:message][:receiver])
    Pusher.app_id = ENV['PUSHER_APP_ID']
    Pusher.key = ENV['PUSHER_KEY']
    Pusher.secret = ENV['PUSHER_SECRET']

    if @message.save
      channel = @message.receiver.username + "-" + current_user.username
      Pusher[channel].trigger('my-event', {message: @message.content, url: @message.sender.get_image})
      respond_to do |format|
        format.html { redirect_to message_path(params[:message][:receiver]) }
        format.js { render layout: false }
      end
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
