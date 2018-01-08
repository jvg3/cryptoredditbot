class CoinsController < ApplicationController

  def index

    now = Time.now.utc

    source = params[:source] if params[:source] && Coin.sources.keys.include?(params[:source].to_sym)
    @one_hour_mentions = mentions_from_date(now - 1.hour, source)
    @one_day_mentions = mentions_from_date(now - 1.day, source)
    @seven_day_mentions = mentions_from_date(now - 1.week, source)

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

  def mentions_from_date(date, source=nil)

    source_clause = "AND mentions.source = ?" if source

    sql = <<-SQL
      SELECT count(*), coins.sym
      FROM mentions
      LEFT JOIN coins ON coins.id = mentions.coin_id
      WHERE mentions.created_at > ?
      #{source_clause}
      GROUP BY coins.sym
      ORDER BY count DESC
    SQL

    params_arr = [date]
    params_arr << source if source

    Mention.find_by_sql([sql].concat(params_arr))

  end

end