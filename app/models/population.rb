# Future considerations
# - For the history buffs out there ...Add BC and AD support for Gregorian
# calendars with a calendar_label field on the populations table. This will
# require re-engineering the method signature and all its dependent callers
# signatures.
#
# [MA]

class Population < ApplicationRecord
  # NOTE: These constants are used for configuring desired output.
  # If we find the need to change this default value, we can make a settings
  # table to pull this from.
  # A comment is a lie waiting to happen.
  # [MA]
  DEFAULT_UNKNOWN_YEAR_POPULATION = 0.freeze

  def self.get(year)
    raise ActiveRecord::RecordNotFound if Population.count == 0

    year = Date.new(year.to_i)

    return DEFAULT_UNKNOWN_YEAR_POPULATION if year < min_year

    pop = if year > max_year
            closest_prior_year(year)
          else
            Population.find_by(year: year) || estimated_population(year)
          end

    # NOTE: nil will return as 0
    pop&.population.to_i
  end

  private

  def self.estimated_population(year)
    prior = closest_prior_year(year)
    forward = closest_forward_year(year)

    population_step = (prior.population - forward.population).abs / (prior.year.year - forward.year.year).abs
    years_stepped = year.year - prior.year.year

    estimate = prior.population + population_step * years_stepped

    OpenStruct.new(population: estimate)
  end

  def self.closest_prior_year(year)
    Population.where("year < ?", year).order(year: :desc).first
  end

  def self.closest_forward_year(year)
    Population.where("year > ?", year).order(year: :desc).first

  end

  def self.min_year
    Population.minimum(:year)
  end

  def self.max_year
    Population.maximum(:year)
  end
end

# == Schema Information
#
# Table name: populations
#
#  id         :integer          not null, primary key
#  year       :date
#  population :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
