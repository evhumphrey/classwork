class Question < ApplicationRecord
  validates :text, :poll_id, presence: true

  belongs_to :poll,
  primary_key: :id,
  foreign_key: :poll_id,
  class_name: "Poll"

  has_many :answer_choices,
  primary_key: :id,
  foreign_key: :question_id,
  class_name: "AnswerChoice"

  has_many :responses,
  through: :answer_choices,
  source: :responses

  def title
    self.text
  end

  def results
    result = {}
    choices = answer_choices
    choices.each do |choice|
      result[choice.text] = choice.responses.length
    end

    result
  end
end
