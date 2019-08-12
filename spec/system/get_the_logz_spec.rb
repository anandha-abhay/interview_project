require 'rails_helper'

RSpec.describe "Get the logz", type: :system do
  it "User is presented with a table of results" do
    visit the_logz_path
    assert_selector "table"
  end
end
