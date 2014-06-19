# == Schema Information
#
# Table name: polls
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  author_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Poll < ActiveRecord::Base
  belongs_to(
  :author,
  primary_key: :id,
  foreign_key: :author_id,
  class_name: "User"
  )
  
  has_many(
  :questions,
  primary_key: :id,
  foreign_key: :poll_id,
  class_name: "Question"
  )
  
  validates :title, :author_id, presence: true
end
