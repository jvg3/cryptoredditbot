class CoinsController < ApplicationController

  def index

    now = Time.now.utc

    @one_hour_mentions = mentions_from_date(now - 1.hour)
    @one_day_mentions = mentions_from_date(now - 1.day)
    @seven_day_mentions = mentions_from_date(now - 1.week)

  end

  def mentions_from_date(date)

    sql = <<-SQL
      SELECT count(*), coins.sym
      FROM mentions
      LEFT JOIN coins ON coins.id = mentions.coin_id
      WHERE mentions.created_at > ?
      GROUP BY coins.sym
      ORDER BY count DESC
    SQL

    Mention.find_by_sql([sql, date])

  end

end