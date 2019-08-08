require 'rails_helper'

RSpec.describe Population, type: :model do

  describe ".get" do

    context "with no records loaded" do
      it "raises an ActiveRecord::RecordNotFound error" do
        expect { Population.get(9001) }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    # TODO: We will want to store these values in lets and run assertions against
    # those stored values instead of hard coding them.
    # [MA]
    context "with records" do

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

      it "accepts a year we know and return the correct population" do
        expect(Population.get(known_year_0)).to eq(known_pop_0)
        expect(Population.get(known_year_1)).to eq(known_pop_1)
      end

      it "accepts a year we don't know and return the previous known population" do
        expect(Population.get(known_year_0 + 1)).to eq(known_pop_0)
        expect(Population.get(known_year_0 + 2)).to eq(known_pop_0)
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

end
