class PopulationsController < ApplicationController
  def index
  end

  # TODO: There may be a cleaner way of doing this
  # Edge cases this messes up: If a decimal value is entered,
  # we round to the nearest integer.
  def show
    begin
      @year = Integer params[:year]
    rescue ArgumentError
      bad_input = true
    end

    @population = Population.get(@year)

    if bad_input
      return head :bad_request
    end

    render :show
  end
end
