class QueryLog < ApplicationRecord
  enum query_type: [:exact, :calculated]

  def self.known_year_query_counts
    find_by_sql(<<~SQL.squish)
      SELECT p.year, COUNT(p.year) kount
      FROM query_logs qlogs
        INNER JOIN populations p ON (qlogs.year = p.year)
      GROUP BY p.year
      ORDER BY kount DESC
    SQL
  end
end
