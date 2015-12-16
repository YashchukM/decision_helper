Rails.application.routes.draw do
  root 'decisions#index'

  get 'results' => 'decisions#results'

  resources :decisions, only: [:index, :create, :new, :show, :update]
  resources :choices, only: [:create, :new]
  resources :criteriums, only: [:create, :new]
end
