class AddTasksIndexToColumnsIndex < ActiveRecord::Migration[6.1]
  def change
    add_index :tasks, :name
    add_index :tasks, :status
    add_index :tasks, :priority
  end
end
