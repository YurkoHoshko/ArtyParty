class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.string :title
      t.date :date
      t.string :location

      t.timestamps
    end
  end
end
