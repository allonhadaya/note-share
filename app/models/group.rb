class Group < ActiveRecord::Base
	belongs_to :user # admin
	has_and_belongs_to_many :users # members
	has_many :notes	
end
