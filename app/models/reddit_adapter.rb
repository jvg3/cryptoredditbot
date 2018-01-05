class RedditAdapter

  def self.get_reddit_data
    coin_regexes = Coin.all.map{ |coin| [" #{coin.sym}", "#{coin.sym} ", " #{coin.name}", "#{coin.name} "] }

    # https://www.reddit.com/r/pics/search.json?sort=new
    res = HTTP.get('https://www.reddit.com/r/cryptocurrency/comments.json')
    json = JSON.parse(res.to_s)
    comments = json['data']['children'].map{ |x| x['data']['body'] }
    comments.each do |comment|

      comment_up = comment.upcase
      coin_regexes.each do |coin_regex|
        match = comment_up.match(Regexp.union(coin_regex))
        if match
          coin = Coin.find_by_sym(match.to_s.strip)
          coin = Coin.find_by_name(match.to_s.strip) unless coin
          Mention.create(coin_id: coin.id, comment: comment) if coin
        end
      end
    end
  end
end
