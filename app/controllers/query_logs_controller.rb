class QueryLogsController < ApplicationController

  # GET /query_logs
  # GET /query_logs.json
  def index
    @query_logs = QueryLog.all
    @popular_queries = QueryLog.known_year_query_counts
  end

end
