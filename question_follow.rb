require_relative 'questions_database'

class QuestionFollow
  def self.followers_for_question_id(question_id)
    query = QuestionsDbConnection.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        question_follows
      JOIN
        questions ON question_id = questions.id
      WHERE
        question_id = ?
    SQL
    query.map { |user| User.new(user) }
  end
end
