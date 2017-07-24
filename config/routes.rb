Rails.application.routes.draw do
  resources :contracts do
    resources :renting_phases
  end
  resources :line_items
  resources :invoices
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
