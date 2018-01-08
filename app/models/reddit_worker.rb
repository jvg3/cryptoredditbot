class RedditWorker
  include Sidekiq::Worker

  def perform(*args)
    puts "STARTING GET_REDDIT_DATA"
    RedditAdapter.get_reddit_data
    puts "DONE GET_REDDIT_DATA"
  end
end