class CreateCoins < ActiveRecord::Migration
  def change
    create_table :coins do |t|
      t.string   :name
      t.string   :sym
      t.timestamps null: false
    end
  end
end
