class ChangeColumnsRemoveDefaltOnTasks < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :name, :string, deafult: "タスク"
  end
end
