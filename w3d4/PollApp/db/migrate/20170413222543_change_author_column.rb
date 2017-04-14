class ChangeAuthorColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :polls, :author
    add_column :polls, :author_id, :integer
    change_column_null :polls, :author_id, false
  end
end
