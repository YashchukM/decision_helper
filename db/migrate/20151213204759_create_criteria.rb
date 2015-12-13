class CreateCriteria < ActiveRecord::Migration
  def change
    create_table :criteria do |t|
      t.integer :importance
      t.integer :valuation
      t.string :name
      t.references :choice, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
