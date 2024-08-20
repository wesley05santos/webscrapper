class AddColumnCompanyToProfiles < ActiveRecord::Migration[7.1]
  def change
    add_column :profiles, :company, :string
  end
end
