class ChangeNameColumnOnTask < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tasks, :name, false, 0
    change_column_default :tasks, :name, from: nil, to: 0
  end
end
