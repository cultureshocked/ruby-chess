 require_relative "./board.rb"

 p_one = Player.new(0)
 p_two = Player.new(1)
 board = Board.new(p_one, p_two)

 board.print_board
