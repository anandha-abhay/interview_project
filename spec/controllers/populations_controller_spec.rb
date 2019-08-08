require 'rails_helper'

RSpec.describe PopulationsController, type: :controller do
  render_views

  let(:known_year_0) { 1900 }
  let(:known_pop_0) { 76212168 }

  let(:known_year_1) { 1990 }
  let(:known_pop_1) { 248709873 }

  let!(:population_0) { create(:population,
                               year: Date.new(known_year_0),
                               population: known_pop_0) }
  let!(:population_1) { create(:population,
                               year: Date.new(known_year_1),
                               population: known_pop_1) }

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
  end
end
