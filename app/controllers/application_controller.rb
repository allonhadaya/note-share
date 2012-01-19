class ApplicationController < ActionController::Base
	protect_from_forgery
	helper_method :current_user_session, :current_user

	private
		def current_user_session
			return @current_user_session if defined?(@current_user_session)
			@current_user_session = UserSession.find
		end

		def current_user
			return @current_user if defined?(@current_user)
			@current_user = current_user_session && current_user_session.user
		end

		def require_user
			unless current_user
				store_location
				flash[:notice] = "You must be logged in to access this page"
				redirect_to new_user_session_url
				return false
			end
		end

		def require_no_user
			if current_user
				store_location
				flash[:notice] = "You must be logged out to access this page"
				redirect_to account_url
				return false
			end
		end

		def etherpad
			return @etherpad if defined?(@etherpad)
			@etherpad = EtherpadLite.connect(:local, File.new('C:\dev\lib\etherpad-lite-win\APIKEY.txt'))
		end

		def require_etherpad
			unless etherpad
				store_location
				flash[:notice] = "Unable to connect to etherpad-lite"
				return false
			end
		end
		
		def require_group
			unless params[:group_name]
				store_location
				flash[:notice] = "Parameter :group_name required"
				return false
			end
		end
		
		def require_group_admin
			return false unless require_group
			return false unless require_user
			@user = current_user
			@group = Group.find_by_name(params[:group_name]) || Group.create(:name => params[:group_name], :admin => current_user, :members => [current_user])
			unless @user.is_admin?(@group)
				store_location
				flash[:notice] = "You must be an admin of #{@group.name} to access this page"
			end
		end
		
		def require_group_member
			return false unless require_group
			return false if (params[:group_name] != 'public' && !require_user)
			@user = current_user || User.anonymous
			@group = Group.find_by_name(params[:group_name]) || Group.create(:name => params[:group_name], :admin => current_user, :members => [current_user])
			unless @user.is_member?(@group)
				store_location
				flash[:notice] = "You must be a member of #{@group.name} to access this page"
			end
		end

		def etherpad_pad(note, user)
			author = etherpad.author(user.id, :name => user.name)
			group = etherpad.group(note.group_id)
			@pad = group.pad(note.id)

			sess = session[:ep_sessions][group.id] ? etherpad.get_session(session[:ep_sessions][group.id]) : group.create_session(author, 60)
			if sess.expired?
				sess.delete
				sess = group.create_session(author, 60)
			end
			session[:ep_sessions][group.id] = sess.id
			cookies[:sessionID] = {:value => sess.id }
		end

		def store_location
			session[:return_to] = request.url
		end

		def redirect_back_or_default(default)
			redirect_to(session[:return_to] || default)
			session[:return_to] = nil
		end
end