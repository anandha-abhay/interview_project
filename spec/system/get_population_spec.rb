require 'rails_helper'

RSpec.describe "Get population by year", type: :system do
  it "User is presented with an input form" do
    visit populations_path
    assert_selector "input[name=year]"
    assert_selector "button[type=submit]"
  end

  describe "When user enters a year" do
    before do
      visit populations_path
        fill_in 'year', with: input_value
        click_button 'Submit'
    end

    context "that is not an integer" do
      let(:input_value) { 'haxx0r' }

      xit 'renders an empty 400 page' do
        pending "Assert the page is empty I guess. But this is really handled in the controller spec."
      end
    end

    context "that is an integer" do
      let(:input_value) { 1990 }

      it "redirects to a results page" do
        expect(current_path).to eq(population_by_year_path)
      end

      it "shows the input year" do
        assert_selector "h3#year", text: input_value
      end

      it "shows a population figure" do
        assert_selector "h3#population", text: 248_709_873
      end

      it "has another form for additional queries" do
        assert_selector "input[name=year]"
        assert_selector "button[type=submit]"
      end

      describe "filling out that form again" do
        let(:input_value) { 19000 }

        before do
          fill_in 'year', with: input_value
          click_button 'Submit'
        end

        it "redirects to a results page" do
          expect(current_path).to eq(population_by_year_path)
        end

        it "shows the input year" do
          assert_selector "h3#year", text: input_value
        end

        it "shows a population figure" do
          assert_selector "h3#population", text: 76_212_168
        end

        it "has another form for additional queries" do
          assert_selector "input[name=year]"
          assert_selector "button[type=submit]"
        end

      end
    end
  end
end
