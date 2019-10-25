class State < ActiveRecord::Base
	has_many :biomes
	has_many :animals, through: :biomes
end