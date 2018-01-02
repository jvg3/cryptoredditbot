class RedditAdapter

  def self.get_reddit_data

    regex_union = Regexp.union([Coin.pluck(:sym), Coin.pluck(:name)].flatten.map(&:upcase))

    # https://www.reddit.com/r/pics/search.json?sort=new
    res = HTTP.get('https://www.reddit.com/r/cryptocurrency/comments.json')
    json = JSON.parse(res.to_s)
    comments = json['data']['children'].map{ |x| x['data']['body'] }
    comments.each do |comment|
      match = comment.upcase.match(regex_union)
      if match
        coin = Coin.find_by_sym(match.to_s)
        coin = Coin.find_by_name(match.to_s) unless coin
        Mention.create(coin_id: coin.id) if coin
      end
    end
  end
end
