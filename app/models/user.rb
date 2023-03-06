class User < ApplicationRecord
  has_many :answers

  validates :name, presence: true
end
