Rails.application.routes.draw do
  resources :contracts, only: [:new, :show, :destroy, :create, :index] do
    resources :renting_phases, only: [:new, :show, :destroy, :create] do
      resources :invoices, only: [:show]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
