class CoinsController < ApplicationController

  def index

    now = Time.now.utc

    source = params[:source] if params[:source] && Coin.sources.keys.include?(params[:source].to_sym)
    @one_hour_mentions = Mention.mentions_from_date(now - 1.hour, source)
    @one_day_mentions = Mention.mentions_from_date(now - 1.day, source)
    @seven_day_mentions = Mention.mentions_from_date(now - 1.week, source)

    respond_to do |format|
      format.html
      format.js {  render layout: false, file: "coins/index.js.erb" }
    end

  end

  def create
    @coin = Coin.new(
      name: params[:name].strip.upcase,
      sym: params[:sym].strip.upcase
    )

    respond_to do |format|
      format.json do
        if @coin.save
          render json: { body: 'ok' }, status: :ok
        else
          render json: { errors: @coin.errors }, status: :unprocessable_entity
        end
      end
    end
  end
end
