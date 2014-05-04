# The Player class has a lot of methods but the only two which are relevant to the the 
# logic of the game are:
# 
#		#prompt_for_move : asks player to make his move
#
# 		#play_at(box_id) : tells the controller to update the game
#
#

class Player
	@@all = []	
	
	attr_reader :name, :symbol
	def initialize name, symbol, controller
		@name = Player.fix_name name
		@symbol = Player.fix_symbol symbol
		@controller = controller
		@@all << self
	end

	def to_s
		"(#{@symbol}) - #{@name}"
	end

	def prompt_for_move
		box_id = nil
		until box_id
			print "#{self}'s turn: "
			box_id = gets.chomp.upcase.to_sym
			box_id = @controller.assert_legal_move_at box_id
		end
		box_id
	end

	def play_at box_id
		board_coordinate = @controller.find_coordinates_of box_id
		@controller.clear box_id
		@controller.update_game(board_coordinate, @symbol)
	end

	def self.all
		@@all
	end

	def self.gui_create_player id, controller
		puts "Hello, Player #{id}"
		puts "What is your name?"
		name = Player.assert_unique(:name, gets.chomp) while name.nil?

		puts "And symbol? (choose any letter)"
		symbol = Player.assert_unique(:symbol, gets.chomp) while symbol.nil?

		puts "\n"
		Player.new(name,symbol,controller)
	end

	private

		def self.assert_unique attribute, value
			#return nil if value.nil?
			if Player.unique? attribute, value
				value
			else
				puts "! - chose a different #{attribute}"
				nil
			end
		end

		def self.unique? attribute, value
			clean_value = Player.send("fix_#{attribute}", value)
			@@all.none? do |player| 
				player.send(attribute) =~ /\A#{clean_value}\z/i
			end
		end

		def self.fix_symbol symbol
			symbol[0]
		end

		def self.fix_name name
			name.capitalize
		end
end