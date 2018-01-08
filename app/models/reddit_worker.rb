class RedditWorker
  include Sidekiq::Worker

  # Sidekiq::Cron::Job.create(name: 'reddit_worker', cron: '* * * * *', class: 'RedditWorker')
  def perform(*args)
    RedditAdapter.get_reddit_data
  end
end