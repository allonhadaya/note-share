class User < ActiveRecord::Base
	acts_as_authentic
	has_and_belongs_to_many :groups
	has_many :admin_groups, :class_name => 'Group'
	
	def is_admin?(group_id)
		self[:admin_groups] && self[:admin_groups].include?(group_id)
	end
	
	def is_member?(group_id)
		self[:groups] && self[:groups].include?(group_id)
	end
	
	def self.anonymous
		find_or_create_by_name('anonymous')
	end
end
