class AddDetailsToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :limit, :datetime
  end
end
