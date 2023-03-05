require_relative "./helper.rb"
require_relative "./coordinate.rb"

class Piece
  include PieceSymbols

  attr_reader :player, :color, :board, :coordinate, :symbol

  def initialize(x, y, player, board)
    @coordinate = Coordinate.new(x, y)
    @player = player
    @color = player.color
    @board = board
    @player.add_piece(self)
    @moves = []
    @control = []
  end

  def legal_moves
    @moves = []
    for t in @transformations
      x_y = @coordinate.x_y
      for i in (0..1)
        x_y[i] += t[i]
      end
      unless x_y[0].between?(0..7) and x_y[1].between?(0..7)
        next
      end
      check_move(x_y, t)
    end
    @moves
  end

  def controlled_squares
    @control = []
    for t in @transformations
      x_y = @coordinate.x_y
      for i in (0..1)
        x_y[i] += t[i]
      end
      unless x_y[0].between?(0..7) and x_y[1].between?(0..7)
        next
      end
      check_control(x_y, t)
    end
    @control
  end

  def move(x_y)
    @coordinate.update(x_y)
  end

  private

  def check_move(x_y, transform)
    piece = @board.query(x_y)
    return false if piece and piece.color == @color
    @moves << x_y
    return piece.nil?
  end

  def check_control(x_y, transform)
    piece = @board.query(x_y)
    @control << x_y
    return piece.nil?
  end
end
