# The purpose of the GameBoard class is simply to keep track of the condition of the game.
#
# Example:
#							A     |     B     |     C
#							-------------------------
#							D     |     E     |     F
#							-------------------------
#							G     |     H     |     I
#
# Methods:
#	 #rows 				# => [["A","B","C"],["D","E","F"],["G","H","I"]]
#
#    #columns			# => [["A","D","G"],["B","E","H"],["C","F","I"]]
#
# 	 #diagonals			# => [["A","E","I"],["G","E","C"]]
#
#
#
# I use these 3 methods in the Logic module to see if there are any winning combination.

require "./board"

class GameBoard < Board
	def initialize size 
		super(size){" "}
	end

	def to_s
		"Game:\n\n#{super}"
	end

	def columns
		@matrix.transpose
	end

	def rows
		@matrix
	end

	def diagonals
		[right_diagonal,left_diagonal]
	end

	private
		def right_diagonal
			@matrix.map.with_index do |row,index|
				row[index]
			end
		end

		def left_diagonal
			@matrix.reverse.map.with_index do |row, rindex|
				 row[rindex]
			end
		end
end