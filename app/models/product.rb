class Product < ApplicationRecord
  belongs_to :category

  has_many :carts

  has_many :favorites

  has_many :buys

  has_many :ratings

  has_one_attached :avatar
end
