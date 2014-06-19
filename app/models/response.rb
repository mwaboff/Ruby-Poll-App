# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  answer_choice_id :integer          not null
#  user_id          :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  belongs_to(
  :answer_choice,
  primary_key: :id,
  foreign_key: :answer_choice_id,
  class_name: "AnswerChoice"
  )
  
  belongs_to(
  :respondent,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: "User"
  )
  
  validates :answer_choice_id, :user_id, presence: true
end
