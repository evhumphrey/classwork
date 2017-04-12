require_relative 'questions_database'

class User
  def self.all
    query = QuestionsDbConnection.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        users
    SQL
    query.map { |data| User.new(data) }
  end

  def self.find_by_name(f_name, l_name)
    query = QuestionsDbConnection.instance.execute(<<-SQL, f_name, l_name)
      SELECT
        *
      FROM
        users
      WHERE
        f_name = ? AND l_name = ?
    SQL
    query.map { |data| User.new(data) }
  end

  attr_accessor :first_name, :last_name
  def initialize(options)
    @id = options['id']
    @first_name = options['f_name']
    @last_name = options['l_name']
  end

  def authored_questions
    Question::find_by_author_id(@id)
  end

  def authored_replies
    Reply::find_by_user_id(@id)
  end
end
