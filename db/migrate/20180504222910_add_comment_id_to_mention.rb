class AddCommentIdToMention < ActiveRecord::Migration
  def change
    add_column :mentions, :comment_id, :integer
  end
end
