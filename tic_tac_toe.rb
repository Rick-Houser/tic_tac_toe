class TicTacToe

	attr_reader :board, :player_1, :player_2, :empty_board 
	def initialize
		@player_1 = Player.new
		@player_2 = Player.new
		@board = Board.new
		@win_Status = nil
		@turn = 1
		@win_Condition = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],
											[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
	end

	def play_Game
		get_Name
		greeting
		begin_Game
		game_Over_Msg
		result
	end

	def get_Name
		print "Player 1, please enter your name: "
		@player_1.name = gets.chomp
		@player_1.sym = "X"
		print "Player 2, please enter your name: "
		@player_2.name = gets.chomp
		@player_2.sym = "O"
	end

	def greeting
		puts "
		===============================================                                              
		 _____ _        _____            _____         
		|_   _|_|___   |_   _|___ ___   |_   _|___ ___ 
		  | | | |  _|    | | | .'|  _|    | | | . | -_|
		  |_| |_|___|    |_| |__,|___|    |_| |___|___|


		===============================================                                               
    "
    @board.show_Board
	end

	def begin_Game
    turn until game_Over
	end

	def turn
		@turn.even? ? validate_Move(@player_1) : validate_Move(@player_2)
	end

	def validate_Move(player)
		move_Prompt(player)
    input = user_Input
    if @board.update(input, player.sym) 
      @turn += 1
    else
      error = "Invalid cell. Please try another."
    end
    @board.show_Board
    puts error
    winner_Check(player)
	end

	def move_Prompt(player)
		puts "#{player.name} ('#{player.sym}') it's your turn."
	end

	def user_Input
		input = nil
		until (0..8).include?(input)
			puts "The board increases (0-9) from left to right and top to bottom."
			puts "Enter the number that corresponds with your chosen space."
			input = gets.chomp.to_i - 1
		end
		input
	end

	def winner_Check(player)
		@win_Condition.each do |w|
			@win_Status = player if w.all? { |i| @board.grid[i] == player.sym }
		end
	end

	def game_Over
		@turn > 9 || @win_Status
	end

	def game_Over_Msg
		puts " 
		 _____                  _____               
		|   __|___ _____ ___   |     |_ _ ___ ___   
		|  |  | .'|     | -_|  |  |  | | | -_|  _|  
		|_____|__,|_|_|_|___|  |_____|\_/|___|_|    
		                                            
		                                       __   
		 _____                        _       |  |  
		|_   _|___ _ _    ___ ___ ___|_|___   |  |  
		  | | |  _| | |  | .'| . | .'| |   |  |__|  
		  |_| |_| |_  |  |__,|_  |__,|_|_|_|  |__|  
		          |___|      |___|                 
		"
	end

	def result 
		if @turn > 9 && !@win_Status
			puts "That's a tie game..."
		else
			puts "#{@win_Status} has won with match! Congrats!"
		end
	end

	class Board
		attr_reader :grid, :empty_board

		def initialize
			@empty_board = '-'
			@grid = Array.new(9, @empty_board)
		end

		def show_Board
			puts "\n"
	    @grid.each_slice(3) { |row| puts row.join(' | ') }
	    puts "\n"
		end

		def update(pos, sym)
			if @grid[pos] == @empty_board
				@grid[pos] = sym
				return true
			else
				return false
			end
		end
	end

	Player = Struct.new(:name, :sym)
end

my_game = TicTacToe.new
my_game.play_Game