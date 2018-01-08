class AddSentimentToMention < ActiveRecord::Migration
  def change
    add_column :mentions, :sentiment, :float
  end
end
