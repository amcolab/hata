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
end
