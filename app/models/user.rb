class User < ApplicationRecord
  has_secure_password
  has_many :orders
  has_many :reviews
  has_one :cart

  validates :userid, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }
end
