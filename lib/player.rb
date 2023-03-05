require_relative "./piece.rb"

class Player

  attr_reader :color

  def initialize(color)
    @color = color
    @pieces = []
    @board = nil
    @check = false
  end

  def add_piece(piece)
    @pieces << piece
  end

  def remove_piece(piece)
    @pieces.delete(piece)
  end

  def register_board(board)
    @board = board
  end

  def turn
    if in_check?
      return check_turn
    end
    move = get_move
    loop do
      src = Coordinate.xy_from_alg(move[0])
      piece = find_piece(src)

      if piece.nil?
        puts "None of your pieces are on that square!"
        move = get_move
        next
      end

      dest = Coordinate.xy_from_alg(move[1])
      unless piece.legal_moves.include?(dest)
        puts "Cannot move to that square."
        move = get_move
        next
      end

      if @board.query(dest)
        puts "Capturing piece on #{move[1]}"
        @board.capture(src, dest)
      else
        puts "Moving to #{move[1]}"
        @board.move(src, dest)
      end
      piece.move(dest)
      break
    end
  end

  def check_turn
    move = get_move
    piece = find_piece(move[0])
  end

  def in_check?
    return @check
  end

  private

  def get_move
    puts "Enter a move (from to)"
    move = gets.chomp.split
    until (move[0].match /^[a-hA-H][1-8]$/ and move[1].match /^[a-hA-H][1-8]$/)
      puts "That move is not valid. Try again."
      move = gets.chomp.split
    end
    move
  end

  def find_piece(x_y)
    for piece in @pieces
      if piece.get_xy == x_y
        return piece
      end
    end
    nil
  end

end
