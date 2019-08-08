module ApplicationHelper

  def year
    # NOTE: We know this is always suppose to be an integer
    # Let's guarantee that.
    @year.to_i
  end

  def population
    @population
  end

end
