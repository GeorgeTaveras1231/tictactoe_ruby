# The Board class is intended to give some structural functionality to the GameBoard class and the ControllerBoard class.
# In essence, its a wrapper for a 2 dimensional array where both outer and inner arrays are of the same length (determined 
# at #initialize).
# (#matrix is an inaccessible instance varialble, but for the sake of the next examples I use it as a public method) 
#
# 		x = Board.new 3
# 		x.matrix 			# => [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
#
# Board#new can also take a code block to determine what the matrix will be filled with; I use this approach when initializing
# the GameBoard and ControllerBoard
#
# 		x = Board.new(3) do |index|
# 			index
# 		end
# 		x.matrix 			# => [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
#
# !* Important methods
# 		#[]= (coordinates, value) : changes the value at ^coordinates with ^value
#				
#
# 						x[0,2] = "changed"
# 						x.matrix 							# => [[0, 1, "changed"], [3, 4, 5], [6, 7, 8]]
#
#  		#find_coordinates_of ("changed")					# => [0,2]
#  				
#
#
#
# 
# Misc. methods
#
# 		#to_s : draws the board
#
#				puts x				 0     |     1     |     2
#									 -------------------------
#									 3     |     4     |     5
#									 -------------------------
#									 6     |     7     |     8
#
class Board
	attr_reader :size
	def initialize size, &fill_with
		@size = size
		@matrix = Board.create_matrix @size,@size, &fill_with
	end

	def to_s
		margin = 4
		row = ''
		@matrix.map do |col|
			# => draw column divider
			row = col.join("#{''.ljust(margin)} | #{''.rjust(margin)}")
		# => draw row divider
		end.join("\n#{'-'*row.length}\n")
	end

	def find_coordinates_of box_id
		coordinates = nil
		@matrix.each_with_index do |row,index|
			if row.include? box_id
				row_index = index
				col_index = row.index(box_id) 
				coordinates = [row_index,col_index]
			end
		end
		coordinates
	end

	protected
		def []= *position, value
			row,col = position
			@matrix[row][col] = value
		end

	private
		def self.create_matrix rows, cols
			Array.new(rows) do |row_index|
				Array.new(cols) do |col_index|
					index = (row_index*rows)+col_index
					yield index if block_given?
				end
			end
		end

end


