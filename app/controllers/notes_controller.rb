class NotesController < ApplicationController
	before_filter :initialize_resources
	
	# render the group page with all the notes in it
	def index
	end
	
	# create a new pad
	def new
		@note = Note.new( :group_id => @group.id, :name => params[:note_name] ) #new or create?
		render :action => :edit
	end
	
	# edit an existing pad
	def edit
		@note = @note || Note.find_by_group_id_and_name(@group.id, params[:note_name])
		etherpad_pad(@group, note, @author)
		render :json => { 'pad_id' => @pad.id, 'author' => @author.name }
	end
	
	# edit the group settings
	def settings
		raise NotImplementedError
	end
	
	private
		def initialize_resources
			if params[:action] == :settings
				require_user
			else
				require_etherpad
			end
		end
end