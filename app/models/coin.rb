class Coin < ActiveRecord::Base

  validates_uniqueness_of :sym
  validates_presence_of :sym, :name
  has_many :mentions

  def self.sources
    sources = {
      reddit_cryptocurrency: 'https://www.reddit.com/r/cryptocurrency/comments.json',
      reddit_bitcoin: 'https://www.reddit.com/r/bitcoin/comments.json',
      reddit_ico: 'https://www.reddit.com/r/icocrypto/comments.json',
      reddit_altcoin: 'https://www.reddit.com/r/altcoin/comments.json',
      reddit_the_donald: 'https://www.reddit.com/r/the_donald/comments.json'
    }
  end

  def self.refresh_coins
    res = HTTP.get('https://api.coinmarketcap.com/v1/ticker/')
    if res.status == 200
      json = JSON.parse(res.to_s)
      json.each do |coin|
        Coin.find_or_create_by(sym: coin['symbol'], name: coin['name'].upcase)
      end
    end
  end

end
