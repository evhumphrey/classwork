require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    values_list = params.values
    where_line = params.keys.map do |attr_name|
      "#{attr_name} = ?"
    end
    where_line = where_line.join(' AND ')

    query = DBConnection.execute(<<-SQL, *values_list)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{where_line}
    SQL

    parse_all(query)
  end
end

class SQLObject
  extend Searchable
end
