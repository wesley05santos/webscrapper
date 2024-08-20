class AddColumnsToProfiles < ActiveRecord::Migration[7.1]
  def change
    add_column :profiles, :repositories, :integer
    add_column :profiles, :followers, :integer
    add_column :profiles, :followings, :integer
    add_column :profiles, :stars, :integer
  end
end
