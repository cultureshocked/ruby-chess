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

  private

  def check_move(x_y, transform)
    return unless super(x_y, transform)
    for i in (0..1)
      x_y[i] += transform[i]
    end
    return unless x_y[0].between?(0, 7) and x_y[1].between?(0, 7)
    check_move(x_y, transform)
  end

  def check_control(x_y, transform)
    return unless super(x_y, transform)
    for i in (0..1)
      x_y[i] += transform[i]
    end
    return unless x_y[0].between?(0, 7) and x_y[1].between?(0, 7)
    check_control(x_y, transform)
  end

end
