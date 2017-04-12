require_relative 'questions_database'

class QuestionLike

  def self.likers_for_question_id(question_id)
    query = QuestionsDbConnection.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        question_likes
        JOIN users ON users.id = liked_user_id
      WHERE
        liked_question_id = ?
    SQL
    query.map { |user| User.new(user) }
  end

  def self.num_likes_for_question_id(question_id)
    query = QuestionsDbConnection.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*) AS num_likes
      FROM
        question_likes
      WHERE
        liked_question_id = ?
      GROUP BY
        liked_question_id
    SQL
    query[0]["num_likes"]
  end

  def self.liked_questions_for_user_id(user_id)
    query = QuestionsDbConnection.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        question_likes
      JOIN
        questions ON liked_question_id = questions.id
      WHERE
        liked_user_id = ?;
    SQL
    query.map { |q| Question.new(q) }
  end
end
