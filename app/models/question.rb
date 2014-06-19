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
  
  def results
    result_hash = {}
    Question.joins(:answer_choices)
    .joins("LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id")
    .group('answer_choices.id')
    .select('answer_choices.body AS rbody, COUNT(responses.answer_choice_id) AS rcount')
    .where('questions.id = ?', id).each do |question|
      result_hash[question.rbody] = question.rcount
    end
    
    result_hash
  end
end
