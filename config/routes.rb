Rails.application.routes.draw do
  resources :groups do
  	resources :group_members do
  	  resources :expenses
  	end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
