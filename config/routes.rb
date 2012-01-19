NoteShare::Application.routes.draw do

	root :to => 'notes#index', :defaults => { :group_name => 'public' }

	match 'signup' => 'users#new', :as => :signup
	match 'login' => 'user_sessions#new', :as => :login
	match 'logout' => 'user_sessions#destroy', :as => :logout
	
	match ':group_name' => 'notes#index'
	match ':group_name/settings' => 'notes#settings'
	match ':group_name/note/:note_name' => 'notes#edit'
	match ':group_name/new' => 'note#new' # ?note-name=:note-name
end
