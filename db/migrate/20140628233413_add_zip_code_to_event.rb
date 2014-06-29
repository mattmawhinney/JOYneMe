class AddZipCodeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :zip_code, :integer
  end
end
