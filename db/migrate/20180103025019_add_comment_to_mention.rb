class AddCommentToMention < ActiveRecord::Migration
  def change
    add_column :mentions, :comment, :string
  end
end
