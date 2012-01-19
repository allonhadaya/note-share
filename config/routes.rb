NoteShare::Application.routes.draw do

	root :to => 'group#index', :defaults => { :id => 'public' }

	match 'signup' => 'users#new', :as => :signup
	match 'login' => 'user_sessions#new', :as => :login
	match 'logout' => 'user_sessions#destroy', :as => :logout
	
	resources :groups do
		resources :notes
	end
end
