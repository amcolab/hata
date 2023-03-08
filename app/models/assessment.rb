# == Schema Information
#
# Table name: assessments
#
#  id                 :bigint           not null, primary key
#  point              :integer
#  assessment_user_id :integer          not null
#  answer_id          :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Assessment < ApplicationRecord
  belongs_to :answer

  scope :by_assessment_user_id, -> (assessment_user_id) {where(assessment_user_id: assessment_user_id)}
  scope :by_answer_id, -> (answer_id) {where(answer_id: answer_id)}
end
