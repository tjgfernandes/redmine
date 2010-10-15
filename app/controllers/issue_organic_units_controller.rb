class IssueOrganicUnitsController < ApplicationController

  menu_item :settings
  before_filter :find_project, :authorize
  
  verify :method => :post, :only => :destroy

  def edit
    if request.post? and @organic_unit.update_attributes(params[:organic_unit])
      flash[:notice] = l(:notice_successful_update)
      redirect_to :controller => 'projects', :action => 'settings', :tab => 'organic_units', :id => @project
    end
  end

  def destroy
    @issue_count = @organic_unit.issues.size
    if @issue_count == 0
      # No issue assigned to this organic_unit
      @organic_unit.destroy
      redirect_to :controller => 'projects', :action => 'settings', :id => @project, :tab => 'organic_units'
    elsif params[:todo]
      reassign_to = @project.issue_organic_units.find_by_id(params[:reassign_to_id]) if params[:todo] == 'reassign'
      @organic_unit.destroy(reassign_to)
      redirect_to :controller => 'projects', :action => 'settings', :id => @project, :tab => 'organic_units'
    end
    @organic_units = @project.issue_organic_units - [@organic_unit]
  end

private
  def find_project
    @organic_unit = IssueOrganicUnit.find(params[:id])
    @project = @organic_unit.project
  rescue ActiveRecord::RecordNotFound
    render_404
  end    
end
