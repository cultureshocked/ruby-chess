require_relative "./piece.rb"

class King < Piece

  def initialize(x, y, player, board)
    super(x, y, player, board)
    @transformations = [
      [1, 0], [-1, 0],
      [0, 1], [0, -1],
      [1, 1], [1, -1],
      [-1, 1], [-1, -1]
    ]
    @symbol = (@color == 0) ? white_king : black_king
  end

end
