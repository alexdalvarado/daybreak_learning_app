class AddPriorityToPatients < ActiveRecord::Migration[8.1]
  def change
    add_column :patients, :priority, :string, default: "normal", null: false
  end
end
