require 'rails_helper'

RSpec.describe PopulationsController, type: :controller do
  render_views

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { year: "1900" }
      expect(response).to have_http_status(:success)
    end

    it "returns a population for a date" do
      year = 1900
      get :show, params: { year: year }
      expect(response.content_type).to eq "text/html"
      expect(response.body).to match /Population: #{Population.get(year)}/im
    end

    it "returns a 400 for bad requests" do
      get :show, params: { year: "><script>alert('XSS')</script>&" }
      expect(response).to have_http_status(:bad_request)
    end

    it "returns a 422 for years beyond our calculatable max" do
      get :show, params: { year: "#{Population::MAX_YEAR + 1}" }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
