class AddSourceToMention < ActiveRecord::Migration
  def change
    add_column :mentions, :source, :string
  end
end
