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

  def initialize(options)
    @id = options['id']
    # @parent = Reply.find_by_user_id(options['parent_id'])
    @parent_id = options['parent_id']
    @user_id = options['user_id']
    @question_id = options['question_id']
    @body = options['body']
  end

end
