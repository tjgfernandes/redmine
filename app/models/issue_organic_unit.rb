#copy from IssueCategory adapted to represent Organic Units
class IssueOrganicUnit < ActiveRecord::Base

  belongs_to :project
  belongs_to :assigned_to, :class_name => 'User', :foreign_key => 'assigned_to_id'
  has_many :issues, :foreign_key => 'organic_unit_id', :dependent => :nullify


  
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:project_id]
  validates_length_of :name, :maximum => 30
  
  alias :destroy_without_reassign :destroy
  
  # Destroy the organic unit
  # If a organic unit is specified, issues are reassigned to this organic unit
  def destroy(reassign_to = nil)
    if reassign_to && reassign_to.is_a?(IssueOrganicUnit) && reassign_to.project == self.project
      Issue.update_all("organic_unit_id = #{reassign_to.id}", "organic_unit_id = #{id}")
    end
    destroy_without_reassign
  end
  
  def <=>(organic_unit)
    name <=> organic_unit.name
  end
  
  def to_s; name end

  
end
