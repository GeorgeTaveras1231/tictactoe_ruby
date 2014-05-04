
module Setup
	def initialize total_players = 2, board_size = 3
		@game_board = GameBoard.new board_size
		@controller_board = ControllerBoard.for @game_board
		@total_players = total_players
	end

	def collect_players
		@total_players.times do |index|
			Player::gui_create_player(index+1, @controller_board)
		end
	end
end