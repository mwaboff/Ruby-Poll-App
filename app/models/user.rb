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
end
