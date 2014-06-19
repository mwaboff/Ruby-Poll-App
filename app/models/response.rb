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
  validate :respondent_is_the_person_who_authored_the_poll
  
  private
  def respondent_has_not_already_answered_question
    has_same_id = (existing_responses.first && (existing_responses.first.id == id))
    unless existing_responses.empty? || has_same_id
      errors[:user_id] << "already answered this question."
    end
  end
  
  def respondent_is_the_person_who_authored_the_poll
    self_response = Response.joins(:answer_choice => {:question => :poll})
      .where("polls.author_id = ?", user_id)
      .where("answer_choices.id = ?", answer_choice_id)
      .select("polls.author_id AS poll_author_id").distinct
    
    if self_response.first.poll_author_id == user_id
      errors[:user_id] << "trying to do his own poll"
    end
  end
    
  def existing_responses
    my_query = <<-SQL
    SELECT
      responses.*
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

