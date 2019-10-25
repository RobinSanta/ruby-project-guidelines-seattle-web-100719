class Biome < ActiveRecord::Base
	belongs_to :animal
	belongs_to :state
end