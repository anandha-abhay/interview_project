require 'rails_helper'

RSpec.describe "QueryLogs", type: :request do
  describe "GET /the_logz" do
    it "works" do
      get the_logz_path
      expect(response).to have_http_status(200)
    end
  end
end
