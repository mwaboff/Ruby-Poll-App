# == Schema Information
#
# Table name: answer_choices
#
#  id          :integer          not null, primary key
#  question_id :integer          not null
#  body        :text             not null
#  created_at  :datetime
#  updated_at  :datetime
#

class AnswerChoice < ActiveRecord::Base
  belongs_to(
  :question,
  primary_key: :id,
  foreign_key: :question_id,
  class_name: "Question"
  )
  
  has_many(
  :responses,
  primary_key: :id,
  foreign_key: :answer_choice_id,
  class_name: "Response"
  )
  
  validates :question_id, :body, presence: true
end
