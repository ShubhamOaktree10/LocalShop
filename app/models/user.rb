require 'bcrypt'
class User < ApplicationRecord
  include BCrypt

  has_many :roles

  has_many :carts

  has_many :favorites

  has_many :buys

  has_many :ratings

  has_many :shops, dependent: :destroy

  validates :FirstName, presence: true
  validates :LastName,  presence: true
  validates :email,     presence: true
  validates :address,   presence: true
  validates :city,      presence: true
  validates :state,     presence: true
  validates :country,   presence: true
  validates :pincode,   presence: true

  has_secure_password
end
