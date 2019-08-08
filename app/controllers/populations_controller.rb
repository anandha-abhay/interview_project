class PopulationsController < ApplicationController
  def index
  end

  def show
    @year = params[:year].match(/^\d+$/) ? params[:year].to_i : nil
    @population = Population.get(@year)

    unless @year
      return head :bad_request
    end

    render :show
  end
end
