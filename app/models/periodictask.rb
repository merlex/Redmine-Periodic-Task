class Periodictask < ActiveRecord::Base
  unloadable
  belongs_to :project
  belongs_to :assigned_to, :class_name => 'User', :foreign_key => 'assigned_to_id'
  
  INTERVAL_UNITS = ['day','week', 'month']
end
