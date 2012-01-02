NoteShare::Application.routes.draw do
	resources :user_sessions
	resources :users
	resource :user, :as => 'account'
	
	match 'signup' => 'users#new', :as => :signup
	match 'login' => 'user_sessions#new', :as => :login
	match 'logout' => 'user_sessions#destroy', :as => :logout
	
	match ':group_id' => 'notes#group'
	match ':group_id/settings' => 'notes#group_settings'
	match ':group_id/pad/:pad_id' => 'notes#pad'
end
