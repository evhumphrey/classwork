require_relative 'questions_database'

class QuestionFollow
  def self.followers_for_question_id(question_id)
    query = QuestionsDbConnection.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        question_follows
      JOIN
        users ON user_id = users.id
      WHERE
        question_id = ?
    SQL
    query.map { |user| User.new(user) }
  end

  def self.followed_questions_for_user_id(user_id)
    query = QuestionsDbConnection.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        question_follows
      JOIN
        questions ON question_id = questions.id
      WHERE
        user_id = ?
    SQL
    query.map { |question| Question.new(question) }
  end

  def self.most_followed_questions(n)
    return [] if n <= 0
    query = QuestionsDbConnection.instance.execute(<<-SQL, n)
      SELECT
        questions.*, COUNT(question_id) AS num_followers
      FROM
        question_follows
        JOIN questions ON question_id = questions.id
      GROUP BY
        question_id
      ORDER BY
        num_followers DESC
      LIMIT
        ?
    SQL
    query.map { |q| Question.new(q) }
  end
end
