require_relative "./piece.rb"

class Player

  attr_reader :color

  def initialize(color)
    @color = color
    @pieces = []
    @board = nil
  end

  def add_piece(piece)
    @pieces << piece
  end

  def register_board(board)
    @board = board
  end

end
