class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :description
      t.string :category
      t.date :date
      t.time :time
      t.string :location
      t.references :user, index: true

      t.timestamps
    end
  end
end
