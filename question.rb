require_relative 'questions_database'

class Question
  def self.find_by_author_id(author_id)
    query = QuestionsDbConnection.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
    SQL
    query.map { |data| Question.new(data) }
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  attr_accessor :title, :body, :author_id
  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def author
    query = QuestionsDbConnection.instance.execute(<<-SQL, @author_id)
      SELECT
        *
      FROM
        users
      WHERE
       id = ?
    SQL
    User.new(query[0])
  end

  def replies
    Reply::find_by_question_id(@id)
  end
end
