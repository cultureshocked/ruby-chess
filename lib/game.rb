require_relative "./board.rb"

def load(board)
  slot = ""
  loop do
    puts "Enter save slot (1-9)"
    slot = gets.chomp
    unless slot.match /^[1-9]$/
      puts "Invalid slot"
      next
    end
    break
  end
  save_file = File.open("save_#{slot}", "r")

  moves = save_file
    .read
    .split
    .map { |move| (move.include?(":")) ? move.split(":") : move }
    .map { |move| (move.class.name == "Array") ? [ [move[0].to_i, move[1].to_i], [move[2].to_i, move[3].to_i], move[4]] : move}

  for move in moves
    p move
    if move == "o-o" or move == "o-o-o"
      board.castle?(move, board.current_turn)
      next
    end
    case move[2]
    when "M"
      board.move(move[0], move[1])
    when "C"
      board.capture(move[0], move[1])
    end
  end

  for y in (0..7)
    for x in (0..7)
      if board.query([x, y])
        board.query([x, y]).move([x, y])
      end
    end
  end
end

p_one = Player.new(0)
p_two = Player.new(1)
board = Board.new(p_one, p_two)

puts "Load game? (Y/N)"
ld = gets.chomp
if ld == "Y"
  load(board)
end

loop do
  break if board.finished
  player = board.current_turn
  board.print_board
  player.turn
end

board.moves.each { |move| p move }
