class AddSentimentSetToMention < ActiveRecord::Migration
  def change
    add_column :mentions, :sentiment_set, :boolean, default: false
  end
end
