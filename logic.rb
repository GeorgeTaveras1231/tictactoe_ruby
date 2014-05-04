# The #victory? method takes a 2 dimensional array and checks if:
#	- the values of the elements in the inner arrays are all the same
#	- none of the values are a string with an empty space (to avoid 
#	returning true at the begining of the game).
#
# The #game_over? method checks for the #victory? condition or whether 
# there are no more legal moves, which would mean there's a tie.
#
#
# Considering the following example:
# 
#							X     |     O     |     X
#							-------------------------
#							O     |     O     |     X
#							-------------------------
#							      |     O     |     
#
#	Methods:
#		@game_board#rows 				# => [["X","O","X"],["O","O","X"],[" ","O"," "]]
#
#   	@game_board#columns				# => [["X","O"," "],["O","O","O"],["X","X"," "]]
#
# 		@game_board#diagonals			# => [["X","O"," "],[" ","O","X"]]
#
#
# Inside of #game_over?
#		
#		all_possible_combinations is assigned the concatination of these 3 arrays resulting in:
#			
#		[["X","O","X"],["O","O","X"],[" ","O"," "],["X","O"," "],["O","O","O"],["X","X"," "],["X","O"," "],[" ","O","X"]]
#
# This 2 dimensional array is then passed to #victory? which should find out
# that there is a victory in the second column.
#
module Logic
	def game_over?
		all_possible_combinations = @game_board.rows + @game_board.columns + @game_board.diagonals
		(victory? all_possible_combinations) || (@controller_board.legal_moves.empty?)
	end	

	def victory? matrix
		symbol = nil
		result = matrix.any? do |set|
			symbol = set.first
			set.all? { |box| box == symbol && box != " " }
		end
		@winner = Player.all.find { |player| player.symbol == symbol } if result
		result
	end
end