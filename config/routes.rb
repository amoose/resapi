require 'api_constraints'

Resapi::Application.routes.draw do

	root :to => 'home#index'

	namespace :api, :defaults => {:format => :json} do
	 	scope :module => :v1, :constraints => ApiConstraints.new(:version => 1, :default => true) do
	    get '(/:ingredient(/:action(/:id)))', controller: 'base'
	  end
	end

	resources :ingredients
	resources :data_sources

	get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  # mount Resque::Server, :at => "/resque"
end
