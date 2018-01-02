class CoinsController < ApplicationController

  def index
    @coins_with_count = Mention.select([Coin.arel_table[:sym], Arel.star.count]).joins(
        Mention.arel_table.join(Coin.arel_table).on(
          Coin.arel_table[:id].eq(Mention.arel_table[:coin_id])
        ).join_sources
      ).order(count: :desc).group(Coin.arel_table[:sym])
  end

end