class CreateMeasurements < ActiveRecord::Migration[5.1]
  def change
    create_table :measurements do |t|
      t.integer :gender
      t.float :age
      t.float :height
      t.float :weight
      t.float :activity_level

      t.belongs_to :user

      t.timestamps
    end
  end
end
