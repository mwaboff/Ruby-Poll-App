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
  validate :respondent_has_not_already_answered_question
  
  private
  def respondent_has_not_already_answered_question
    unless existing_responses.empty?
      errors[:user_id] << "already answered this question."
    end
  end
    
  def existing_responses # for a specific user
    my_query = <<-SQL
    SELECT
      *
    FROM
      responses JOIN answer_choices ON answer_choice_id = answer_choices.id 
    WHERE 
      responses.user_id = ?
    AND
      answer_choices.question_id = 
        (SELECT
          question_id
        FROM
          answer_choices ac
        WHERE
          ac.id = ?)
    SQL
    Response.find_by_sql([my_query, user_id, answer_choice_id]);
  end
  
end

