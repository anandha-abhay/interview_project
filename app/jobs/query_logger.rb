class QueryLogger < ApplicationJob
  queue_as :default

  def perform(year, population)
    QueryLog.create({year: year, population: population})
  end
end
