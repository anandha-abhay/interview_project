require 'rails_helper'

RSpec.describe QueryLogsController, type: :controller do
  render_views

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_successful
    end
  end
end
