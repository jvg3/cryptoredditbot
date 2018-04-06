class Mention < ActiveRecord::Base
  belongs_to :coin
  validates_uniqueness_of :comment, scope: :coin_id

  def self.mentions_from_date(date, source=nil)

    source_clause = "AND mentions.source = ?" if source

    sql = <<-SQL
      SELECT count(*), AVG(mentions.sentiment), coins.sym
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
