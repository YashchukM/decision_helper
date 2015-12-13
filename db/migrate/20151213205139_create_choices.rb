class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.string :name
      t.references :decision, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
