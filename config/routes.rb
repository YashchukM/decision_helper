Rails.application.routes.draw do
  root 'decisions#index'

  get 'decisions/index'
  get 'decisions/show'

end
