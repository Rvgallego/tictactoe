class Board
  attr_reader :grid

  def initialize
    @grid = {
 		A1: ' ',
 		B1: ' ',
 		C1: ' ',
 		A2: ' ',
 		B2: ' ',
 		C2: ' ',
 		A3: ' ',
 		B3: ' ',
 		C3: ' ',
 	}
  end

  def draw_grid
  	columns = 0
  	row = 2

  	print "    A     B     C\n1"

    @grid.each do |space, value|
   	  print "|  #{value}  "
   	  columns += 1
   	  if columns == 3
   	  	print "|\n#{row}" if row < 4
   	  	row += 1
   	  	columns = 0
   	  end
   	end

   	print "|\n"
  end

  def update(location,piece_type)
    @grid[location] = piece_type
  end

  def check_win(piece)
  	checks = 0
    wins = [
      [:A1,:A2,:A3],[:B1,:B2,:B3],[:C1,:C2,:C3],[:A1,:B1,:C1],
      [:A2,:B2,:C2],[:A3,:B3,:C3],[:A1,:B2,:C3],[:C1,:B2,:A3]
    ]

    wins.each do |i|
      i.each do |slot|
        checks += 1 if @grid[slot] == piece
      end
      if checks == 3
      	return true
      else
      	checks = 0
      end
    end
    false
  end

end


class Player
  attr_reader :piece_type, :name

  def initialize(name, piece_type)
    @name = name
    @piece_type = piece_type
  end

  def move(board_state,location)
    location = location.to_sym
    if board_state[location] != " "
      puts "Selecciona un espacio valido porfavor"
    else
      location
    end
  end
end

def play(player, board)
  puts "#{player.name}, hace tu movimiento:"

  move_location = nil
  while move_location == nil
    location = gets.chomp.upcase
    move_location = player.move(board.grid, location)
  end

  board.update(move_location, player.piece_type)
  board.draw_grid
end

def tie_check(grid)
  count = 0
  grid.each do |key, value|
    count += 1 if value == ' '
  end
  count
end

board = Board.new #<-- board players -->
board.draw_grid

puts
puts "-----Bienvenidos al juego Tic Tac Toe!-----"
puts "-------------------------------------------"
puts "Jugador 1, Porfavor ingrese su nombre:"
p1_name = gets.chomp
puts "-------------------------------------------"
puts "Jugador 2, Porfavor ingrese su nombre:"
p2_name = gets.chomp
puts "-------------------------------------------"
puts "-------------------------------------------"
puts "Jugador 1 juega X, Jugador 2 juega O"
puts "Digita tu movimiento (ex: A1 - B3 - C2)!"
puts "Jugador 1 juega primero!"
puts "-------------------------------------------"
puts "-------------------------------------------"
player1 = Player.new(p1_name, 'X')
player2 = Player.new(p2_name, 'O')

turns = 0 #<-- start game -->
while true
  play(player1, board)
  if board.check_win(player1.piece_type) == true
  	puts "#{player1.name} ENHORABUENA GANASTE!!!"
  	break
  end

  if tie_check(board.grid) == 0
    puts "EMPATE! INTENTELO DENUEVO!!!"
    break
  end

  play(player2,board)
  if board.check_win(player2.piece_type) == true
  	puts "#{player2.name} ENHORABUENA GANASTE!!!"
  	break
  end
end
