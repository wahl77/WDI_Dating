class Subscription < ActiveRecord::Base
  belongs_to :user
  attr_accessible :stripe_customer_token

  attr_accessor :stripe_card_token
  attr_accessible :stripe_card_token

  after_save :upgrade_user

  def save_with_payment
    begin
      customer = Stripe::Customer.create(description: user_id, plan: "paid_user", card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating customer: #{e.message}"
      errors.add :base, "There was a problem with your credit card."
      false
    end
  end

  def upgrade_user
    user.upgrade
  end

end
