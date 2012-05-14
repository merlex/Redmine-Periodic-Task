class PeriodictaskController < ApplicationController
  unloadable

  before_filter :find_project, :authorize , :only => [:index, :edit]
  before_filter :find_project
  before_filter :find_periodictask, :except => [:new, :index]
  before_filter :load_users, :except => [:destroy]
  before_filter :load_priorities, :except => [:destroy]

  def index
    if !params[:project_id] then return end
    @project_identifier = params[:project_id]
    @project = Project.find(params[:project_id])
    @tasks = Periodictask.find_all_by_project_id(@project[:id])
  end
  def update
    if !params[:project_id] then return end
    @periodictask = Periodictask.find(params[:id])
    @periodictask.update_attributes(params[:periodictask])
      if @periodictask.save
        flash[:notice] = l(:message_periodic_task_updated)
        redirect_to :controller => 'periodictask', :action => 'index', :project_id=>params[:project_id]
      end
  end
  def new
    if !params[:project_id] then return end
    @project = Project.find(params[:project_id])
    @periodictask = Periodictask.new(:project=>@project, :author_id=>User.current.id)
    if request.post?
      params[:periodictask][:project_id] = @project[:id]
      @periodictask.attributes = params[:periodictask]
      if @periodictask.save
        flash[:notice] = l(:message_periodic_task_created)
        redirect_to :controller => 'periodictask', :action => 'index', :project_id=>params[:project_id]
      end
    end

  end

  def edit
    if request.post?
      @periodictask = Periodictask.find(params[:id])
      params[:periodictask][:project_id] = params[:project_id]
      if request.post?
        if @periodictask.update_attributes(params[:periodictask])
          flash[:notice] = l(:message_periodic_task_updated)
          redirect_to :action => 'index', :project_id => params[:project_id]
        end
      end
    end
  end

  def destroy
      @task = Periodictask.find(params[:id])
      @task.destroy
      redirect_to :action => 'index', :project_id => params[:project_id]
  end
private
  def find_periodictask
    @periodictask = Periodictask.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
  def find_project
    @project = Project.find(params[:project_id])
  end
  
  def load_users
    # Get the users that are members in the project
    #
    #@users = User.find_by_sql('SELECT users.id, CONCAT(users.firstname, \' \', users.lastname) fullname FROM members INNER JOIN users
    #  ON members.user_id = users.id
    #  WHERE project_id = ' + @project[:id].to_s + '
    #  AND status = 1
    #  ORDER BY firstname ASC')
    @project = Project.find(params[:project_id])
    @users = []
    @project.members.each do |m|
      @users << m.user
    end

  end
  def load_priorities
    #
    @priorities = IssuePriority.all
  end
end
