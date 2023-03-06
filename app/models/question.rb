class Question < ApplicationRecord
  has_many :answers

  enum status: { inactive: 0, active: 1, archived: 2 }
end
