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
    let(:known_pop_0) { 76212168 }

    let(:known_year_1) { 1990 }
    let(:known_pop_1) { 248709873 }

    let(:estimated_1_step_population) { 78128809 }
    let(:estimated_2_step_population) { 80045450 }

    it "accepts a year we know and return the correct population" do
      expect(Population.get(known_year_0)).to eq(known_pop_0)
      expect(Population.get(known_year_1)).to eq(known_pop_1)
    end

    it "accepts a year we don't know and returns an estimated population" do
      expect(Population.get(known_year_0 + 1)).to eq(estimated_1_step_population)
      expect(Population.get(known_year_0 + 2)).to eq(estimated_2_step_population)
    end

    it "accepts a year that is before earliest known and returns zero" do
      expect(Population.get(known_year_0 - 1)).to eq(Population::DEFAULT_UNKNOWN_YEAR_POPULATION)
      expect(Population.get(0)).to eq(Population::DEFAULT_UNKNOWN_YEAR_POPULATION)
      expect(Population.get(-1000)).to eq(Population::DEFAULT_UNKNOWN_YEAR_POPULATION)
    end

    it "accepts a year that is after latest known and return the last known population" do
      expect(Population.get(2000)).to eq(known_pop_1)
      expect(Population.get(200000)).to eq(known_pop_1)
    end

  end

end
