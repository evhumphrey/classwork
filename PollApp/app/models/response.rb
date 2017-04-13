class Response < ApplicationRecord
  validate :not_duplicate_response, :same_poll_author
  validates :user_id, :answer_choice_id, presence: true

  belongs_to :respondent,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: "User"

  belongs_to :answer_choice,
  primary_key: :id,
  foreign_key: :answer_choice_id,
  class_name: "AnswerChoice"

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    all_responses = question.responses
    all_responses.where.not('responses.id = ?', self.id)
  end

  def respondent_already_answered?
    siblings = question.responses
    p "SIBLINGS"
    p siblings
    p "Self user_id: #{self.user_id}"
    siblings.exists?(user_id: self.user_id)
  end

  def not_duplicate_response
    if respondent_already_answered?
      self.errors[:base] << "User already responded to question"
    end
  end

  def same_poll_author
    author_id = question.poll.author.id
    if author_id == self.user_id
      self.errors[:base] << "Author can't respond to his/her own post"
    end
  end
end
