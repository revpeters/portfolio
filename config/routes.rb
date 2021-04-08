Rails.application.routes.draw do
  root 'home#index'
  get '/investments', to: 'investments#index'
  get '/investments/new', to: 'investments#new', as: 'new_investment'
  post '/investments', to: 'investments#create'
  get '/dividends', to: 'dividends#index'
  get '/dividends/new', to: 'dividends#new', as: 'new_dividend'
  post '/dividends', to: 'dividends#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
