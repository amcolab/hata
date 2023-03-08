# == Schema Information
#
# Table name: answers
#
#  id          :bigint           not null, primary key
#  content     :string
#  total_point :integer
#  user_id     :integer          not null
#  question_id :integer          not null
#  status      :integer          default("active")
#  round       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :assessments

  enum status: { active: 0, archived: 1 }

  scope :with_round, -> (round) { where(round: round) }

  validates :content, presence: true, on: :update
  validates :content, length: { maximum: 140 }, allow_blank: true
  validates :question_id, uniqueness: { scope: %i(user_id round) }

  def update_point!(point, assessment_user)
    self.update!(total_point.to_i + point.to_i)
    self.assessments.create!(point: point, assessment_user_id: assessment_user.id)
  end
end
