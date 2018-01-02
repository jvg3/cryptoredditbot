class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.belongs_to :coin
      t.string  :url
      t.timestamps null: false
    end
  end
end
