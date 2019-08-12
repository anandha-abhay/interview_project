Rails.application.routes.draw do
  get 'the_logz', to: 'query_logs#index', as: :the_logz

  get 'populations', to: 'populations#index'
  get 'populations/by_year', to: 'populations#show', as: :population_by_year
end
