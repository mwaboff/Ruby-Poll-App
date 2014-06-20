# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  has_many(
  :authored_polls,
  primary_key: :id,
  foreign_key: :author_id,
  class_name: "Poll"
  )
  
  has_many(
  :responses,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: "Response"
  )
  validates :user_name, uniqueness: true, presence: true
  
  def qs_per_poll
    Poll.joins(:questions => :answer_choices)
    .select("polls.*, COUNT(DISTINCT questions.id) questions_in_poll")
    .group("polls.id")
  end
  
  def resps
    Poll.joins(:questions => :answer_choices)
    .joins("LEFT OUTER JOIN responses on responses.answer_choice_id = answer_choices.id")
    .select("polls.*, COUNT(responses.id) AS answers")
    .group("polls.id")
    .where("responses.user_id" => self.id)
  end
  
  def completed_polls
    qs = qs_per_poll
    rs = resps
    
    qs.select do |poll|
      poll_questions = poll.questions_in_poll
      poll_responses = rs.find{|r_poll| r_poll.id == poll.id}
      poll.questions_in_poll == (rs.find {|rp| rp.id == poll.id}.answers)
    end
  end
  
    #
  # def check_polls
  #   User.joins(:responses => {:answer_choice => {:question => :poll}})
  # end
  #
  # questions_answered = Question.joins(:answer_choices => :responses)
  # .group('poll.id')
  # .where('responses.user_id', id).distinct
end
