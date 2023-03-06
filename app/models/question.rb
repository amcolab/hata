class Question < ApplicationRecord
  has_many :answers

  enum status: { inactive: 0, active: 1, archived: 2 }

  scope :with_round, -> (round) { where(current_round: round) }

  class << self
    def find_or_create_active_question
      unless question = self.active.first
        max_round = self.maximum(:current_round)
        unless self.inactive.exists?
          self.update_all(status: 'inactive', current_round: max_round + 1)
        end
        question = self.inactive.sample
        question.update!(status: 'active', current_round: max_round || 1) if question
      end
      question
    end
  end
end
