require_relative 'questions_database'

class Reply

  def self.find_by_user_id(user_id)
    query = QuestionsDbConnection.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL

    query.map { |data| Reply.new(data) }
  end

  def self.find_by_question_id(question_id)
    query = QuestionsDbConnection.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL

    query.map { |data| Reply.new(data) }
  end

  def initialize(options)
    @id = options['id']
    # @parent = Reply.find_by_user_id(options['parent_id'])
    @parent_id = options['parent_id']
    @user_id = options['user_id']
    @question_id = options['question_id']
    @body = options['body']
  end

  def author
    self.class.find_by_user_id(@user_id).first
  end

  def question
    self.class.find_by_question_id(@question_id).first
  end

  def parent_reply
    return nil if @parent_id.nil?
    
    query = QuestionsDbConnection.instance.execute(<<-SQL, @parent_id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    Reply.new(query.first)
  end

  def child_replies
    query = QuestionsDbConnection.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL
    query.map { |data| Reply.new(data) }
  end

end
