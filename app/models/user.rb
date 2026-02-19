class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :plan
  has_one :profile

  attr_accessor :stripe_card_token
  def save_with_subscription
    if valid?
      customer = Stripe::Customer.create(
        email: email,
        source: stripe_card_token,
        description: "Customer for #{email}"
      )
      Stripe::Subscription.create(
        customer: customer.id,
        items: [{ plan: plan_id }]
      )
      self.stripe_customer_token = customer.id
      save!
    end
  rescue Stripe::CardError => e
    errors.add(:base, e.message)
    false
  end

  def to_param
    # Returns "1-john-doe"
    # The safe navigation operator (&.) prevents errors if profile is missing
    "#{id}-#{profile&.first_name}-#{profile&.last_name}".parameterize
  end
end
