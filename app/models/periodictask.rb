class Periodictask < ActiveRecord::Base
  unloadable
  belongs_to :project
  belongs_to :assigned_to, :class_name => 'User', :foreign_key => 'assigned_to_id'
  belongs_to :priority, :class_name => 'IssuePriority', :foreign_key => 'priority_id'

  INTERVAL_UNITS = ['day','week', 'month']
end
