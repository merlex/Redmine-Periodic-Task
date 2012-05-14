class AddPriorityIdToPeriodictasks < ActiveRecord::Migration
  def self.up
    add_column :periodictasks, :priority_id, :integer
  end

  def self.down
    remove_column :periodictasks, :priority_id
  end
end
