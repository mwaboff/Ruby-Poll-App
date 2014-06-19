# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  poll_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  has_many(
  :answer_choices,
  primary_key: :id,
  foreign_key: :question_id,
  class_name: "AnswerChoice"
  )
  
  belongs_to(
  :poll,
  primary_key: :id,
  foreign_key: :poll_id,
  class_name: "Poll"
  )
  
  validates :body, :poll_id, presence: true
end
