# require 'tty-font'
# require 'tty-prompt'
# require 'pastel'
# require './config/environment'
require 'pry'

class DamnNature

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
		puts "Enter 3 Check the list of animal names."
		puts ''
		puts "Enter 4 to edit the scientific name of an animal."
		puts ''
		puts "Enter 5 to edit the information on an animal."
		puts ''
		puts "Enter 99 to remove list an animal as extint, removing them from the data base."
		puts ''
		puts "Enter 6 if you wish for the destruction of deer."
	end

	def running
		# print "Animal Name: "
		# input1 = gets.chomp
		# puts "State Name or State Abbreviation: "
		# input2 = gets.chomp

		instructions
		input = gets.chomp.to_i

		if input == 1
			puts "Remeber to capitalize."
			puts "Enter the name of the animal you encountered."
			name = gets.chomp
			puts "Enter the name or abbreviation of the state you were in."
			state = gets.chomp
			animal_encounter(name, state)
		elsif input == 4
			puts "Remeber to capitalize."
			name = gets.chomp
			puts "What animal are you giving a scientific name?"
			scientific_name = gets.chomp
			research_scientific_name(name, input)
		elsif input ==5
			puts "Which animal's profile must be updated?"
			name = gets.chomp
			puts "Tell us what you've learned."
			facts = gets.chomp
			research_animal_fact(name, input)
		elsif input == 2
			puts "What animal do you want to learn about?"
			name = gets.chomp
			animal_info(name)
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
		puts "Bio: #{animal.animal_fact}"
		puts "Scientific Name: #{animal.scientific_name}"
		puts ""
	end

	def display_animal_list
		Animal.all.map {|animal| animal.name}
	end

	def research_scientific_name(name, input)
		animal_research = Animal.find_by(name: name)
		animal_research.update(scientific_name: input)
		puts "An interesting name."
	end

	def research_danger_rating(name, input)
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

	def research_animal_fact(name, input)
		animal_research = Animal.find_by(name: name)
		animal_research.update(animal_fact: input)
		puts "Fasinating. What a marvel of nature."
	end

	def research_predator(name, input)
		animal_research = Animal.find_by(name: name)
		animal_research.update(predator: input)
		if input == true
			puts "Quite the meat eater."
		elsif input == false
			puts "Quite the plant eater."
		end
	end

	def i_am_become_death_destroyer_of_worlds(name)
		Animal.destroy(name: name)
		puts "An unfortunate turn of events."
	end

	def the_hooved_rats_breath_their_last
		Animal.destroy(name: "White-Tailed Deer")
		puts "FINALLY!"
	end
end