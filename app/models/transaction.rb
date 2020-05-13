class Transaction < ApplicationRecord
  require "payjp"
  belongs_to :user
  belongs_to :product
end
