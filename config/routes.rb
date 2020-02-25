Rails.application.routes.draw do
  get 'book_comments/create'
  get 'book_comments/destroy'
  get 'favorites/create'
  get 'favorites/destroy'
	get 'home/about'
	devise_for :users
	root to: 'home#top'
	resources :users, only: [:show, :index, :edit, :update]
	resources :books, only: [:show, :index, :create, :edit, :update, :destroy] do
		resource :favorites, only: [:create, :destroy]
		resource :book_comments, only: [:create, :destroy]
	end
end
