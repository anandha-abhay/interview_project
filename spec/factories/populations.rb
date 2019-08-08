FactoryBot.define do
  factory :population do
    sequence :year do |n|
      Date.new(1900 + 10 * n)
    end

    population { rand 10_000..400_000_000 }
  end
end
