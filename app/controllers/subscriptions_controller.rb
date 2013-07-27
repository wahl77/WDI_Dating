class SubscriptionsController < ApplicationController
  def new
    @subscription = current_user.subscriptions.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subscription }
    end
  end

  def create
    @subscription = current_user.subscriptions.build(params[:subscription])
    if @subscription.save_with_payment
      redirect_to current_user, :notice => "Thank you for subscribing!"
    else
      render :new
    end
  end
end
