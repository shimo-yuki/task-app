class AddAssignToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :assign, :integer
  end
end
