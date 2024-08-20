class AddColumnLocationToProfiles < ActiveRecord::Migration[7.1]
  def change
    add_column :profiles, :location, :string
  end
end
