require_relative "./board.rb"

p_one = Player.new(0)
p_two = Player.new(1)
board = Board.new(p_one, p_two)

loop do
  player = board.current_turn
  board.print_board
  player.turn
end
