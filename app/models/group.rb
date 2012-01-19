class Group < ActiveRecord::Base
	belongs_to :admin, :class_name => 'User'
	has_and_belongs_to_many :members, :class_name => 'User'
	has_many :notes, :inverse_of => :group
end