require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # store column names in instance variable
    # if queried, return our instance var (which has column names)
    # if not queried yet, do the query to get column names
    @column_names ||= (
      DBConnection.execute2(<<-SQL)
        SELECT
          *
        FROM
          #{self.table_name}
      SQL
      ).first.map(&:to_sym)
  end

  def self.finalize!
    columns.each do |column|
      getter_name = column
      define_method(getter_name) do
        self.attributes[getter_name]
      end

      setter_name = "#{column}=".to_sym
      define_method(setter_name) do |set_value|
        self.attributes[column] = set_value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    # if @table_name is already defined, return it
    # otherwise, tableize the self (class) name
    @table_name ||= self.to_s.tableize
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
