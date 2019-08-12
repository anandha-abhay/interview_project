class QueryLog < ApplicationRecord
  enum query_type: [:exact, :calculated]
end
