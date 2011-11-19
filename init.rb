require 'redmine'

Redmine::Plugin.register :redmine_periodictask do
  name 'Redmine Periodictask plugin'
  author 'Tanguy de Courson'
  description 'This is a plugin for Redmine that will allow you to schedule a task to be assigned on a schedule'
  version '1.0.1'

  project_module :redmine_periodictask do

    permission :view_periodictask, :periodictask => :index
    permission :edit_periodictask, :periodictask => :edit
  end
  
  menu :project_menu, :periodictask, { :controller => 'periodictask', :action => 'index' }, :caption => :title_periodic_task, :after => :settings, :param => :project_id
end
