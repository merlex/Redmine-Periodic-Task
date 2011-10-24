class AddDescriptionToPeriodictasks < ActiveRecord::Migration
  def self.up
    add_column :periodictasks, :description, :text
  end

  def self.down
    remove_column :periodictasks, :description
  end
end
