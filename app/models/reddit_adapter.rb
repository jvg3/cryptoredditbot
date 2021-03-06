class RedditAdapter

  def self.get_reddit_data
    Coin.sources.each do |source, subreddit|
      self.get_subreddit_data(source, subreddit)
    end
    # SentimentWorker.perform_async
  end

  def self.get_subreddit_data(source, subreddit)
    coin_regexes = Coin.all.map{ |coin| Regexp.union([/\b#{coin.sym}\b/, /\b#{coin.name}\b/]) }

    res = HTTP.get(subreddit)
    json = JSON.parse(res.to_s)
    comments = json['data']['children'].map{ |x| x['data'] }
    comments.each do |comment_json|

      comment_up = comment_json['body'].upcase
      coin_regexes.each do |coin_regex|
        match = comment_up.match(coin_regex)
        if match
          coin = Coin.find_by_sym(match.to_s.strip)
          coin = Coin.find_by_name(match.to_s.strip) unless coin
          Mention.create(
            source: source,
            coin_id: coin.id,
            comment: comment_json['body'],
            comment_id: comment_json['id'],
            sentiment: 0.5,
            sentiment_set: false,
            post_title: comment_json['link_title'],
            url: comment_json['permalink']) if coin
        end
      end
    end
  end
end
