# Ruby version of tic-tac-toe by George Taveras 2/7/2014
#
# Written in Ruby 2.0

require "./controller_board"
require "./game_board"
require "./player"
require "./setup"
require "./logic"


class TicTacToe
	include Setup
	include Logic

	def introduce
		puts "\nTicTacToe by George Taveras ## Flatiron Exercise\n\n"
	end

	def render_boards
		puts @game_board
		puts "\n\n"
		puts @controller_board
		puts "\n\n"
	end

	def announce_winner
		if @winner
			puts "Congratulations #{@winner.name}, you've won!"
		else
			puts "Its a draw."
		end
	end

	def game_loop
		introduce
		collect_players
		Player.all.cycle do |player| 
			render_boards
			break if game_over?
			decision = player.prompt_for_move
			player.play_at decision
		end
		announce_winner
	end
end

game = TicTacToe.new 2, 3 				#=> 2 players, 3x3 board
game.game_loop


