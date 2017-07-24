Rails.application.routes.draw do
  resources :contracts
  resources :line_items
  resources :invoices
  resources :renting_phases
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
