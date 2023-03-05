require_relative "./piece.rb"

class Knight < Piece

  def initialize(x, y, player, board)
    super(x, y, player, board)
    @transformations = [
      [1, 2], [-1, 2], [-1, -2], [1, -2],
      [2, 1], [-2, 1], [-2, -1], [2, -1]
    ]
    @symbol = (@color == 0) ? white_knight : black_knight
  end

end
