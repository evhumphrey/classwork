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
    query = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL
    parse_all(query)
  end

  def self.parse_all(results)
    results.map do |result_hash|
      self.new(result_hash)
    end
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})

    params.each do |attr_name, value|
      attr_name = attr_name.to_sym

      unless self.class.columns.include?(attr_name)
        raise "unknown attribute '#{attr_name}'"
      end

      self.send("#{attr_name}=", value)
    end
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
