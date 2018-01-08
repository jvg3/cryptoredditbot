class AddTitleToMention < ActiveRecord::Migration
  def change
    add_column :mentions, :post_title, :string
  end
end
