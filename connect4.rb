require "highline/import"
# the highline gem allows us to ask for user imput through the terminal
# "gem install highline" to use the gem

class Board
	@@board = [
							[nil, nil, nil, nil, nil, nil, nil],
	            [nil, nil, nil, nil, nil, nil, nil],
	            [nil, nil, nil, nil, nil, nil, nil],
	            [nil, nil, nil, nil, nil, nil, nil],
	            [nil, nil, nil, nil, nil, nil, nil],
	            [nil, nil, nil, nil, nil, nil, nil]
	      	]
	def initialize
		# puts "new board"
		self.render
	end
	# this method renders the map. it'll run when the game is initialized
	def render
		puts `clear` #this clears the terminal to keep the playing space clean
		for i in 0...@@board.length
			mapping_array = @@board[i].map { |e| renderHelper(e) }
			puts mapping_array.join('|')
		end
	end

	# this method helps map the array using .map and the block
	def renderHelper(el)
		if el === nil
			return ' '
		else
			return el
		end
	end

	# method to mark the columns
	# drops in an 'x' or 'o' and stacks on top of existing x's and o's
	def mark_column(column, player)
		for i in (@@board.length-1).downto(0)
			if @@board[i][column] === nil
				@@board[i][column] = player
				return true
			end
		end
		return false
	end

	# method to check wins
	def check_wins(column, player)
		# row checking
		for i in 0...@@board.length
			row = @@board[i]
			row_counter = 0
			for j in 0...row.length
				if row[j] === player
					row_counter += 1
					if row_counter === 4
						return true
					end
				else
					row_counter = 0
				end
			end
		end

		# column checking
		column_counter = 0
		for k in 0...@@board.length
			if @@board[k][column] === player
				column_counter += 1
				if column_counter === 4
					return true;
				end
			end
		end

		# diagonal checking, chose to go to 11 because coordinates [5,6] can be
		#reached in this loop
		for diagonal_sum in 0..11
			diagonal_counter = 0
			for x in 0..diagonal_sum
				y = diagonal_sum - x
				if (defined?(@@board[x][y])).nil?
					# some of the coordinates being checked are not defined, this is to
					# keep looping through the board to check values on the board
					next
				end
				if @@board[x][y] === player
					diagonal_counter += 1
					if diagonal_counter === 4
						return true
					end
				else
					diagonal_counter = 0
				end
			end
		end

		# other diagonal checking
		for diagonal_diff in (6).downto(-5)
			y = 0
			other_diagonal_counter = 0
			for x in 0...7
				y = diagonal_diff + x
				if (defined?(@@board[x][y])).nil? #if a space is undefined, just keep checking
					next
				end
				if y < 7
					if @@board[x][y] === player
						other_diagonal_counter += 1
						if other_diagonal_counter === 4
							return true
						end
					else
						other_diagonal_counter = 0
					end
				else
					break;
				end
			end
		end
		# the check_wins method has many nested for loops, which is a
		# runtime complexity of O(n^2)
		return false
	end

	#method to determine the player's turn
	def player_turn(player)
		puts "it is " + player + "'s turn!"
		input = ask("Choose a column (1-7): ", Integer){ |q| q.in = 1..7}
		player_column = input - 1 #subtracted 1 so that it corresponds with the right array index, but still allows a human experience
		if self.mark_column(player_column, player)
			self.render
			##### check wins #####
			if self.check_wins(player_column, player)
				return puts player + " has won!"
			end
			# if no one wins, start the next player
			if player === 'x'
				player_turn('o')
			else
				player_turn('x')
			end
		else
			puts "this column is full"
			player_turn(player)
		end
	end

#class closer end
end

new_game = Board.new
new_game.player_turn('x')
