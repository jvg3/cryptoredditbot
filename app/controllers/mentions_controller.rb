class MentionsController < ApplicationController

  def index
    @coin = Coin.find_by_sym(params[:coin])
    @mentions = @coin.mentions.limit(50).order({ created_at: :desc }) if @coin
  end

end