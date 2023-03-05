require_relative "./helper.rb"
require_relative "./player.rb"
require_relative "./pawn.rb"
require_relative "./rook.rb"
require_relative "./queen.rb"
require_relative "./king.rb"
require_relative "./bishop.rb"
require_relative "./knight.rb"
require_relative "./coordinate.rb"


class Board

  def initialize(p_one, p_two)
    @grid = Array.new(8) { Array.new(8) {nil} }
    @players = [p_one, p_two]
    @current_turn = @players[0]

    p_one.register_board(self)
    p_two.register_board(self)

    @turns = 0
    @finished = false

    #White pawns
    for i in (0..7) do
      @grid[6][i] = Pawn.new(i, 6, @players[0], self)
    end

    #Black pawns
    for i in (0..7) do
      @grid[1][i] = Pawn.new(i, 1, @players[1], self)
    end

    #Bishops
    @grid[7][2] = Bishop.new(2, 7, @players[0], self)
    @grid[7][5] = Bishop.new(5, 7, @players[0], self)
    @grid[0][2] = Bishop.new(2, 0, @players[1], self)
    @grid[0][5] = Bishop.new(5, 0, @players[1], self)

    #Knights
    @grid[7][1] = Knight.new(1, 7, @players[0], self)
    @grid[7][6] = Knight.new(6, 7, @players[0], self)
    @grid[0][1] = Knight.new(1, 0, @players[1], self)
    @grid[0][6] = Knight.new(6, 0, @players[1], self)

    #Rooks
    @grid[7][0] = Rook.new(0, 7, @players[0], self)
    @grid[7][7] = Rook.new(7, 7, @players[0], self)
    @grid[0][0] = Rook.new(0, 0, @players[1], self)
    @grid[0][7] = Rook.new(7, 0, @players[1], self)

    #Queens
    @grid[7][3] = Queen.new(3, 7, @players[0], self)
    @grid[0][3] = Queen.new(3, 0, @players[1], self)

    #Kings
    @grid[7][4] = King.new(4, 7, @players[0], self)
    @grid[0][4] = King.new(4, 0, @players[1], self)
  end

  def print_board
    (@current_turn == @players[0]) ? print_white : print_black
  end

  def query(x_y)
    if x_y.class.name == "Coordinate"
      return @grid[x_y.y][x_y.x]
    end
    return @grid[x_y[1]][x_y[0]]
  private

  def print_white
    puts ""
    for i in (0..7)
      print "#{(i - 8).abs} "
      for j in (0..7)
        if @grid[i][j]
          print "#{@grid[i][j].symbol} "
        else
          print "  "
        end
      end
      print "\n"
    end
    puts "  A B C D E F G H"
  end

  def print_black
    puts ""
    for i in (0..7).reverse_each
      print "#{(i - 8).abs} "
      for j in (0..7).reverse_each
        if @grid[i][j]
          print "#{@grid[i][j].symbol} "
        else
          print "  "
        end
      end
      print "\n"
    end
    puts "  H G F E D C B A"
  end

end
