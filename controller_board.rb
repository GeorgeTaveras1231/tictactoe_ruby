# The main purpose of the ControllerBoard class is the delegate changes in the game board;
# It makes sure that the moves that the player makes are legal, and updates the changes
# on the game board. Therefore, it is initialized with a reference to the game board.
#
#
require "./board"

class ControllerBoard < Board
	attr_reader :legal_moves
	def initialize game_board
		@game_board = game_board
		@legal_moves = []
		super(@game_board.size) do |index| 
			box_id = ("A".ord+index).chr.to_sym 
			@legal_moves << box_id
			box_id
		end
	end

	def to_s
		"Controller:\n\n#{super}"
	end

	def update_game coordinates, symbol
		@game_board[*coordinates] = symbol
	end

	def legal_move? box_id	
		@legal_moves.include? box_id
	end

	def clear box_id
		coordinates = self.find_coordinates_of box_id
		self[*coordinates] = " "
		illegalize(box_id)
	end

	def assert_legal_move_at box_id
		unless legal_move? box_id
			puts "! - That move is illegal."
			nil
		else
			box_id
		end
	end

	def self.for game_board
		ControllerBoard.new game_board
	end

	private
		def illegalize box_id
			index = @legal_moves.index(box_id.to_sym)
			@legal_moves.slice!(index)
		end
end
