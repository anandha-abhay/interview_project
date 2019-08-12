require "rails_helper"

RSpec.describe QueryLogsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/the_logz").to route_to("query_logs#index")
    end
  end
end
