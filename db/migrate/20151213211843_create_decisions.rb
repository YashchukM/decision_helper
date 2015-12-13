class CreateDecisions < ActiveRecord::Migration
  def change
    create_table :decisions do |t|
      t.string :name
      t.references :best_abs
      t.references :best_user
      t.references :best_balanced

      t.timestamps null: false
    end
  end
end
