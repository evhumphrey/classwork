# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
user1 = User.create(user_name: "ned")
user2 = User.create(user_name: "cat")
user3 = User.create(user_name: "dog")
user4 = User.create(user_name: "banana")
user5 = User.create(user_name: "san_francisco")

Poll.destroy_all

poll1 = Poll.create(title: "cat's are cool", author_id: user2.id)
poll2 = Poll.create(title: "dog's are the best", author_id: user3.id)
poll3 = Poll.create(title: "SF is the funnest city", author_id: user5.id)

Question.destroy_all
question1 = Question.create(text: "What is your favorite cat?", poll_id: poll1.id)
question2 = Question.create(text: "What is your favorite dog?", poll_id: poll2.id)
question3 = Question.create(text: "What is your favorite thing in SF?", poll_id: poll3.id)

AnswerChoice.destroy_all
# question1 choices
q1_choice1 = AnswerChoice.create(text: "Fluffy cats", question_id: question1.id)
q1_choice2 = AnswerChoice.create(text: "Social cats", question_id: question1.id)
q1_choice3 = AnswerChoice.create(text: "Sleepy cats", question_id: question1.id)

#question2 choices
q2_choice1 = AnswerChoice.create(text: "Big dogs", question_id: question2.id)
q2_choice2 = AnswerChoice.create(text: "Small dogs", question_id: question2.id)
q2_choice3 = AnswerChoice.create(text: "I like them both", question_id: question2.id)

#question3 choices
q3_choice1 = AnswerChoice.create(text: "Golden Gate Bridge", question_id: question3.id)
q3_choice2 = AnswerChoice.create(text: "Treasure Island", question_id: question3.id)
q3_choice3 = AnswerChoice.create(text: "Oakland", question_id: question3.id)
