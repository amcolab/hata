class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :assessments

  enum status: { active: 0, archived: 1 }

  scope :with_round, -> (round) { where(round: round) }
end
