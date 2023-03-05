require_relative "./piece.rb"

class Pawn < Piece

  def initialize(x, y, player, board)
    super(x, y, player, board)
    @transformations = [
      [0, 2], [0, 1],
      [-1, 1], [1, 1]
    ]
    if @color == 0
      @transformations = @transformations.map { |t| [t[0], t[1] * -1] }
    end
    @symbol = (@color == 0) ? white_pawn : black_pawn
    @has_moved = false
  end

  def legal_moves
    @moves = []
    for t in @transformations
      next if t == nil
      x = @coordinate.x + t[0]
      y = @coordinate.y + t[1]
      next unless (x.between?(0, 7) and y.between?(0, 7))
      square = @board.query([x, y])
      unless t[0] == 0
        if square && square.color != @color
          @moves << [x, y]
        else
          next
        end
      else
        if square
          next
        else
          @moves << [x, y]
        end
      end
    end
    @moves
  end

  def controlled_squares
    control = []
    for t in @transformations[2..3]
      x = @coordinate.x + t[0]
      y = @coordinate.y + t[1]
      if (x.between?(0, 7) and y.between?(0, 7))
        control << [x, y]
      end
    end
    control
  end

  def move(x_y)
    super(x_y)
    if @has_moved == false
      @transformations[0] = nil
      @has_moved = true
    end
  end

end
