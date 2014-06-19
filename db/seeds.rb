# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActiveRecord::Base.transaction do
  
  User.create!([{user_name: "1 Bob"},
                {user_name: "2 Sally"},
                {user_name: "3 Alice"},
                {user_name: "4 Bertramp"},
                {user_name: "5 Thor"}
                ])
  
  Poll.create!([{title: "1 Better Person", author_id: 5},
                {title: "2 My_First_Poll", author_id: 1},
                {title: "3 Poll 3", author_id: 1}
                ])
  
  Question.create!([{body: "1 Who is better, Michael (obviously) or Hannah?", poll_id: 1},
                    {body: "2 Why is Michael better?", poll_id: 1},
                    {body: "3 goo goo gaa gaa?", poll_id: 2},
                    {body: "4 why is a baby making this?", poll_id: 2},
                    {body: "5 Some question here?", poll_id: 3}
                    ])
              
  AnswerChoice.create!([{body: "1 Michael", question_id: 1},
                        {body: "2 Hannah", question_id: 1},
                        {body: "3 He is a swell guy.", question_id: 2},
                        {body: "4 His stunning good looks.", question_id: 2},
                        {body: "5 gaa gaa", question_id: 3},
                        {body: "6 goo goo", question_id: 3},
                        {body: "7 End of times", question_id: 4},
                        {body: "8 dunno m8", question_id: 4},
                        {body: "9 Some answer response", question_id: 5}
                        ])
                        
                        
  Response.create!([{answer_choice_id: 1, user_id: 2},
                    {answer_choice_id: 1, user_id: 3},
                    {answer_choice_id: 4, user_id: 2},
                    {answer_choice_id: 4, user_id: 3},
                    {answer_choice_id: 5, user_id: 5},
                    {answer_choice_id: 6, user_id: 2},
                    {answer_choice_id: 6, user_id: 1},
                    {answer_choice_id: 9, user_id: 2},
                    ])
end