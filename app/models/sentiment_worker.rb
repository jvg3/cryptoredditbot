class SentimentWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'default'

  # Sidekiq::Cron::Job.all
  # Sidekiq::Cron::Job.create(name: 'reddit_worker', cron: '7 * * * *', class: 'RedditWorker')
  def perform(*args)
    puts "STARTING SENTIMENT ANALYSIS"
    Mention.where(source: 'reddit_cryptocurrency', sentiment: nil).where('created_at > ?', Time.now.utc - 10.minutes).each do |mention|
      if mention.comment
        mention.update(sentiment: Sentimentalizer.analyze(mention.comment).overall_probability)
      end
    end
    puts "DONE SENTIMENT ANALYSIS"
  end
end