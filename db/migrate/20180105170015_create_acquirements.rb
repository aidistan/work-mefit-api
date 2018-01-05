class CreateAcquirements < ActiveRecord::Migration[5.1]
  def change
    create_table :acquirements do |t|
      t.float :calories
      t.float :fat
      t.float :protein
      t.float :carbohydrate

      t.belongs_to :user
      t.belongs_to :requirement

      t.timestamps
    end
  end
end
