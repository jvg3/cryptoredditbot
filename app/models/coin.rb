class Coin < ActiveRecord::Base

  has_many :mentions

  def self.seed_coins
    Coin.sym_list.each do |sym|
      Coin.find_or_create_by(name: sym[:name].upcase, sym: sym[:sym].upcase)
    end
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
