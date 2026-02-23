class AddLastSeenToPatients < ActiveRecord::Migration[8.1]
  def change
    add_column :patients, :last_seen, :datetime
  end
end
