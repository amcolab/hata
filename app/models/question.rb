# == Schema Information
#
# Table name: questions
#
#  id            :bigint           not null, primary key
#  content       :string           not null
#  status        :integer          default("inactive")
#  time_start    :datetime
#  current_round :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Question < ApplicationRecord
  has_many :answers

  enum status: { inactive: 0, active: 1, archived: 2 }

  scope :with_round, -> (round) { where(current_round: round) }

  class << self
    def find_or_create_active_question
      unless question = self.active.first
        max_round = self.maximum(:current_round) || 0
        unless self.inactive.exists?
          self.update_all(status: 'inactive', current_round: max_round + 1)
        end
        question = self.inactive.sample
        question.update!(status: 'active', current_round: max_round || 1, time_start: Time.now) if question
      end
      question
    end
  end
end
