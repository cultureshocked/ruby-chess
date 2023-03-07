require_relative "./piece.rb"

class King < Piece

  attr_reader :has_moved

  def initialize(x, y, player, board)
    super(x, y, player, board)
    @transformations = [
      [1, 0], [-1, 0],
      [0, 1], [0, -1],
      [1, 1], [1, -1],
      [-1, 1], [-1, -1]
    ]
    @symbol = (@color == 0) ? white_king : black_king
    @has_moved = false
  end

  def move(x_y)
    unless @has_moved
      @has_moved = true
    end
    super(x_y)
  end

end
