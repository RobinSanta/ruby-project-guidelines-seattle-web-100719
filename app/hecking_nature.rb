# require 'tty-font'
# require 'tty-prompt'
# require 'pastel'
# require './config/environment'
require 'pry'

class HeckingNature

	def instructions
		puts ''
		puts "Welcome to the 'Damn, nature, you scary!' database."
		puts ''
		puts "Danger ratings are usually set from 1-5."
		puts "1 = Pretty much harmless and tends to run away."
		puts "2 = Dangerous if provoked."
		puts "3 = Deadly if approached."
		puts "4 = Deadly if approached. Highly aggressive."
		puts "5 = This animal will kill for fun."
		puts ''
		puts "Enter 1 to archive your wildlife encountor."
		puts ''
		puts "Enter 2 to learn abount an animal."
		puts ''
		puts "Enter 3 Check the list of animal names in the database."
		puts ''
		puts "Enter 4 to update the scientific name of an animal."
		puts ''
		puts "Enter 5  to update the danger rating of an animal."
		puts ''
		puts "Enter 6 to update the bio of an animal."
		puts ''
		puts "Enter 7 to update the predator status of an animal."
		puts ''
		puts "Enter 8 to remove list an animal as extint, removing them from the database."
		puts ''
		puts "Enter 66 if you wish for the destruction of deer."
	end

	def running

		instructions
		input = gets.chomp.to_i

		if input == 1
			puts "Remember to capitalize."
			puts "Enter the name of the animal you encountered."
			name = gets.chomp
			puts "Enter the name or abbreviation of the state you were in."
			state = gets.chomp
			animal_encounter(name, state)
		elsif input == 2
			puts "Remember to capitalize."
			puts "Which animal do you want to learn about?"
			name = gets.chomp
			display_animal_info(name)
		elsif input == 3
			display_animal_list()
		elsif input == 4
			puts "Remember to capitalize."
			puts "Which animal is getting a new scientific name?"
			name = gets.chomp
			puts "What is this name?"
			scientific_name = gets.chomp
			update_scientific_name(name, scientific_name)
		elsif input == 5
			puts "Remember to capitalzie."
			puts "Which animal's danger rating must be updated?"
			name = gets.chomp
			puts  "What is this new danger rating?"
			num = gets.chomp.to_i
			update_danger_rating(name, num)
		elsif input == 6
			puts "Remember to capitalize."
			puts "Which animal's bio must be updated?"
			name = gets.chomp
			puts "Tell us what you've learned."
			facts = gets.chomp
			update_animal_fact(name, facts)
		elsif input == 7
			puts "Remember to capitalize."
			puts "Which animal had new eating habits discovered?"
			name = gets.chomp
			puts "Is this animal a predator? Write a lowercase true or false"
			status = gets.chomp
			update_predator_staus(name, status)
		elsif input == 8
			puts "Remember to capitalize."
			puts "Which species has meet its end?"
			name = gets.chomp
			i_am_become_death_destroyer_of_worlds(name)
		elsif input == 66
			puts "Execute order 66."
			the_hooved_rats_breath_their_last()
		end
	end

	def animal_encounter(name, state)
		state_id = 0
		if state.length == 2
			state_id = State.find_by(abbr: state).id
		else
			state_id = State.find_by(name: state).id
		end

		animal = Animal.find_by(name: name)
		if animal == nil
			puts "What a find! A new species! It has been given the name you 	suggested."
			Animal.create(name: name)
			animal_id = Animal.find_by(name: name).id
			Biome.create(animal_id: animal_id, state_id: state_id)
		else
			animal_id = Animal.find_by(name: name).id
			if Biome.find_by(animal_id: animal_id, state_id: state_id) == nil
				puts "We didn't think this animal lived in this area. Like a real scientist, you will not be thanked for your discovery until long after your death."
				Biome.create(animal_id: animal_id, state_id: state_id)
			else
				puts "This animal has already been documented in this area. You are a disgrace to science."
			end
		end
	end

	def display_animal_info(name)
		# binding.pry
		animal = Animal.find_by(name: name)
		puts "Name: #{animal.name}"
		puts "Scientific Name: #{animal.scientific_name}"
		puts "Danger Rating: #{animal.danger_rating}"
		puts "Bio: #{animal.animal_fact}"
		puts "Predator Status: #{animal.predator}"
	end

	def display_animal_list
		animal = Animal.all.map {|animal| animal.name}
		animal.each do |a|
			puts a
		end
	end

	def update_scientific_name(name, input)
		animal_research = Animal.find_by(name: name)
		animal_research.update(scientific_name: input)
		puts "An interesting name."
	end

	def update_danger_rating(name, input)
		animal_research = Animal.find_by(name: name)
		animal_research.update(danger_rating: input)
		if input == 1
			puts "Pretty much harmless and tends to run away."
		elsif input == 2
			puts "Dangerous if provoked."
		elsif input == 3
			puts "Deadly if approached."
		elsif input == 4
			puts "Deadly if approached. Highly aggressive."
		elsif input == 5
			puts "This animal will kill for fun."
		end
	end

	def update_animal_fact(name, input)
		animal_research = Animal.find_by(name: name)
		animal_research.update(animal_fact: input)
		puts "Fasinating. What a marvel of nature."
	end

	def update_predator_staus(name, input)
		animal_research = Animal.find_by(name: name)
		animal_research.update(predator: input)
		if input == true
			puts "Quite the meat eater."
		elsif input == false
			puts "Quite the plant eater."
		end
	end

	def i_am_become_death_destroyer_of_worlds(name)
		Animal.where(name: name).destroy_all
		puts "An unfortunate turn of events."
	end

	def the_hooved_rats_breath_their_last
		Animal.where(name: "White-Tailed Deer").destroy_all
	end
end

