require_relative 'questions_database'

class User
  def self.all
    all = []
    query = QuestionsDbConnection.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        users
    SQL
    query.each { |data| all << User.new(data) }
    all
  end


  attr_accessor :first_name, :last_name
  def initialize(options)
    @id = options['id']
    @first_name = options['f_name']
    @last_name = options['l_name']
  end
end
