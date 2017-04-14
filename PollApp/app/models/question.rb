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

    # SELECT answer_choices.*, COUNT(responses) FROM answer_choices LEFT JOIN responses ON responses.answer_choice_id = answer_choices.id WHERE answer_choices.question_id = #{self.id} GROUP BY answer_choices.id
    # assume we return array (not hash)
    #  -- this returs array of AnswerChoice objects
    #  -- how do we view the count from the AnswerChoice object (because AnswerChoice.count actually works, how do we see that 'count' is a column)
    arr = self.answer_choices.select('answer_choices.text, COUNT(responses) AS count').joins('LEFT JOIN responses ON responses.answer_choice_id = answer_choices.id').where('answer_choices.question_id = ?', self.id).group('answer_choices.id')
    hash = {}
    arr.each do |row|
      hash[row.text] = row.count
    end

    hash
  end
end
