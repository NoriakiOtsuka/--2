Rails.application.routes.draw do
	get 'home/about'
	devise_for :users
	root to: 'home#top'
	resources :users,only: [:show,:index,:edit,:update]
	resources :books,only: [:show,:index,:create,:edit,:update,:destroy]
end
