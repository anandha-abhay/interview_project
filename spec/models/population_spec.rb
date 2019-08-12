require 'rails_helper'

RSpec.describe Population, type: :model do

  describe ".get" do
    context "with no records loaded" do
      before do
        allow(Population).to receive(:count) { 0 }
      end

      it "raises an ActiveRecord::RecordNotFound error" do
        expect { Population.get(9001) }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    let(:known_year_0) { 1900 }
    let(:known_pop_0) { 76_212_168 }

    let(:known_year_1) { 1990 }
    let(:known_pop_1) { 248_709_873 }

    let(:linear_1_step_population) { 78_128_809 }
    let(:linear_2_step_population) { 80_045_450 }

    let(:future_year_0) { 2000 }
    let(:exponential_growth_population_0) { 588_786_718 }
    let(:future_year_1) { 2020 }
    let(:exponential_growth_population_1) { 3_299_802_627 }

    it "accepts a year we know and return the correct population" do
      expect(Population.get(known_year_0)).to eq(known_pop_0)
      expect(Population.get(known_year_1)).to eq(known_pop_1)
    end

    it "accepts a year we don't know and returns a population predicted using linear growth" do
      expect(Population.get(known_year_0 + 1)).to eq(linear_1_step_population)
      expect(Population.get(known_year_0 + 2)).to eq(linear_2_step_population)
    end

    it "accepts a year that is before earliest known and returns zero" do
      expect(Population.get(known_year_0 - 1)).to eq(Population::DEFAULT_UNKNOWN_PAST_YEAR_POPULATION)
      expect(Population.get(0)).to eq(Population::DEFAULT_UNKNOWN_PAST_YEAR_POPULATION)
      expect(Population.get(-1000)).to eq(Population::DEFAULT_UNKNOWN_PAST_YEAR_POPULATION)
    end

    it "accepts a year that is after latest known and returns a population estimated based on exponential growth" do
      expect(Population.get(future_year_0)).to eq(exponential_growth_population_0)
      expect(Population.get(future_year_1)).to eq(exponential_growth_population_1)
    end

    it "sends results off to get logged" do
      allow(QueryLogger).to receive :perform_now
      Population.get(known_year_0)
      expect(QueryLogger).to have_received(:perform_now).with(known_year_0, known_pop_0)
    end
  end
end
