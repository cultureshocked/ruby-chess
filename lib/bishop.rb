require_relative "./piece.rb"
require_relative "./helper.rb"

class Bishop < Piece

  def initialize(x, y, player, board)
    super(x, y, player, board)
    @transformations = [
      [1, 1], [1, -1],
      [-1, 1], [-1, -1]
    ]
    @symbol = (@color == 0) ? white_bishop : black_bishop
  end

end
