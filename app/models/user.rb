class User < ActiveRecord::Base
	acts_as_authentic
	has_many :groups # admin
	has_and_belongs_to_many :groups # member
end
