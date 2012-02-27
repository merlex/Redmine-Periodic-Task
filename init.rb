require 'redmine'

Redmine::Plugin.register :redmine_periodictask do
  name 'Redmine Periodictask plugin'
  author 'Tanguy de Courson'
  description 'This is a plugin for Redmine that will allow you to schedule a task to be assigned on a schedule'
  version '1.0.3'

  project_module :periodic_tasks do
     permission :view_periodictask, :periodictask => [:index, :edit]
#    permission :view_periodictask, :periodictask => :index
#    permission :edit_periodictask, :periodictask => :edit
  end
  
  menu :project_menu, :periodictask, { :controller => 'periodictask', :action => 'index' },:if => Proc.new{ Redmine::AccessControl::allowed_actions(:view_periodic_task) }, :caption => :title_periodic_task, :before => :settings, :param => :project_id
end
