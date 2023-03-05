require_relative "./piece.rb"

class Rook < Piece

  def initialize(x, y, player, board)
    super(x, y, player, board)
    @transformations = [
      [1, 0], [-1, 0],
      [0, 1], [0, -1],
    ]
    @symbol = (@color == 0) ? white_rook : black_rook
  end

end
