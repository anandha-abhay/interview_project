class PopulationsController < ApplicationController
  def index
  end

  def show
    @year = params[:year].match(/^\d+$/) ? params[:year].to_i : nil

    unless @year
      return head :bad_request
    end

    if @year > Population::MAX_YEAR
      return head :unprocessable_entity
    end

    @population = Population.get(@year)

    render :show
  end
end
