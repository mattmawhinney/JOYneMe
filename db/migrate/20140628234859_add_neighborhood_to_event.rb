class AddNeighborhoodToEvent < ActiveRecord::Migration
  def change
    add_column :events, :neighborhood, :string
  end
end
