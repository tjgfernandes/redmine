class CreateIssueOrganicUnits < ActiveRecord::Migration
  def self.up
    create_table :issue_organic_units, :force => true do |t|
      t.integer :project_id, :default=>0, :null=>false
      t.string :name, :limit => 30, :default => "", :null => false
      t.integer :assigned_to_id
      t.timestamps
    end

    add_index "issue_organic_units", ["project_id"], :name => "issue_organic_units_project_id"

  end

  def self.down
    drop_table :issue_organic_units
  end
end
