class Animal < ActiveRecord::Base
	has_many :biomes
	has_many :states, through: :biomes
end

