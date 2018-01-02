class CreateRequirements < ActiveRecord::Migration[5.1]
  def change
    create_table :requirements do |t|
      t.string :formula
      t.float :calories
      t.float :fat
      t.float :protein
      t.float :carbohydrate

      t.belongs_to :user
      t.belongs_to :measurement

      t.timestamps
    end
  end
end
