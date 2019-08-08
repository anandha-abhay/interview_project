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
  MAX_YEAR = 2500.freeze
  GROWTH_RATE = 1.09
  # NOTE: This constant name is getting out of control.
  DEFAULT_UNKNOWN_PAST_YEAR_POPULATION = 0.freeze

  def self.get(year)
    raise ActiveRecord::RecordNotFound if Population.count == 0

    year = year

    return DEFAULT_UNKNOWN_PAST_YEAR_POPULATION if year < min_year

    pop = if year > max_year
            estimated_future_population(year)
          else
            Population.find_by(year: year) || estimated_from_known_populations(year)
          end

    # NOTE: nil will return as 0
    pop&.population.to_i
  end

  private

  # NOTE: Hold onto your butts, math is about to happen.
  # https://giphy.com/gifs/samuel-l-jackson-jurassic-park-hold-onto-your-butts-OCu7zWojqFA1W
  def self.estimated_future_population(year)
    latest_population = closest_prior_year(year)
    time = year - latest_population.year

    # TODO: Move this into a population caclculation module
    # NOTE: This uses the exponential growth formula.
    pop = latest_population.population.to_f * GROWTH_RATE ** time

    # NOTE: This is my attempt to build a step wise recursive function to simulate
    # population growth by year.
    # calculate_growth = lambda do |pop, steps_left|
    #   memo = pop * GROWTH_RATE
    #   steps_left -= 1

    #   steps_left == 0 ? memo : calculate_growth.call(memo, steps_left)
    # end

    # pop = calculate_growth.call(latest_population.population, steps)

    OpenStruct.new(population: pop)
  end

  def self.estimated_from_known_populations(year)
    prior = closest_prior_year(year)
    forward = closest_forward_year(year)

    # TODO: Move this into a population caclculation module
    population_step = (prior.population - forward.population).abs / (prior.year - forward.year).abs
    years_stepped = year - prior.year

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
