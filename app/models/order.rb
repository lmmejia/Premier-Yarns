class Order < ApplicationRecord
  PAYMENT_TYPES = [ "Credit Card", "Klarna", "Shop Pay", "PayPal" ].freeze

  belongs_to :user
  has_many :cartitems

  validates :paytype, inclusion: { in: PAYMENT_TYPES }
end
