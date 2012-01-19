class Note < ActiveRecord::Base
	belongs_to :group, :inverse_of => :notes
end