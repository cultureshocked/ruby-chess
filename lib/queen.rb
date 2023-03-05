require_relative "./piece.rb"

class Queen < Piece

  def initialize(x, y, player, board)
    super(x, y, player, board)
    @transformations = [
      [1, 0], [-1, 0],
      [0, 1], [0, -1],
      [1, 1], [1, -1],
      [-1, 1], [-1, -1]
    ]
    @symbol = (@color == 0) ? white_queen : black_queen
  end

end
