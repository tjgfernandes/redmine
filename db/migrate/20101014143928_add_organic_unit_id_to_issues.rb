class AddOrganicUnitIdToIssues < ActiveRecord::Migration
  def self.up
    add_column :issues, :organic_unit_id, :integer

    add_index :issues, :organic_unit_id
  end

  def self.down
    remove_column :issues, :organic_unit_id
  end
end
