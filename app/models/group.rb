class Group < ActiveRecord::Base
	belongs_to :admin, :class_name => 'User'
	has_and_belongs_to_many :members, :class_name => 'User'
	has_many :notes, :inverse_of => :group
	
	def self.public
		find_by_name('public')
	end
	
	def self.public!
		create(:name => 'public', :admin => User.find_by_name('allonhadaya'), :members => [User.anonymous])
	end
end
