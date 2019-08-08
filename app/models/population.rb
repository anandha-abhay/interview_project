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

    pop = Population.where("year <= ?", year).order(year: :desc).first

    pop&.population
  end

  private

  def self.min_year
    # Future considerations
    # - For the history buffs out there ...Add BC and AD support for Gregorian
    # calendars with a calendar_label field on the populations table. This will
    # require re-engineering the method signature and all its dependent callers
    # signatures.
    #
    # [MA]
    Population.minimum(:year)
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
