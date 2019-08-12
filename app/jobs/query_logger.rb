class QueryLogger < ApplicationJob
  queue_as :default

  def perform(year, population, calculated)
    QueryLog.create({
      year: year,
      population: population,
      query_type: calculated ? :calculated : :exact
    })
  end
end
