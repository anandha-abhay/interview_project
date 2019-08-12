class QueryLogsController < ApplicationController

  # GET /query_logs
  # GET /query_logs.json
  def index
    @query_logs = QueryLog.all
  end

end
