require_relative "./piece.rb"

class Player

  attr_reader :color, :king, :pieces, :opponent
  attr_writer :check

  def initialize(color)
    @color = color
    @pieces = []
    @board = nil
    @check = false
    @opponent = nil
    @king = nil
  end

  def add_piece(piece)
    @pieces << piece
    if piece.class.name == "King"
      @king = piece
    end
  end

  def remove_piece(piece)
    @pieces.delete(piece)
  end

  def register_board(board)
    @board = board
  end

  def register_opponent(player)
    @opponent =  player
  end

  def turn

    if @board.check?(self)
      puts " **** IN CHECK!!! **** "
      return check_turn
    end

    legal = []
    for piece in @pieces
      legal.concat piece.legal_moves
    end
    return @board.stalemate if legal.length == 0

    move = get_move
    loop do
      if move.class.name == "String"
        if move.downcase == "o-o" or move.downcase == "o-o-o"
          if @board.castle?(move, self)
            return
          else
            puts "Cannot castle in that direction."
            move = get_move
            next
          end
        end
      end
      src = Coordinate.xy_from_alg(move[0])
      piece = find_piece(src)

      if piece.nil?
        puts "None of your pieces are on that square!"
        move = get_move
        next
      end


      dest = Coordinate.xy_from_alg(move[1])
      unless piece.legal_moves.include?(dest)
        puts "Cannot move to that square."
        move = get_move
        next
      end

      if @board.query(dest)
        puts "Capturing piece on #{move[1]}"
        unless @board.capture(src, dest)
          puts "That piece is pinned and cannot capture!"
          move = get_move
          next
        end
      else
        puts "Moving to #{move[1]}"
        unless @board.move(src, dest)
          puts "That piece is pinned!"
          move = get_move
          next
        end
      end
      piece.move(dest)
      break
    end
  end

  def check_turn

    king_coord = @king.get_xy

    # How many pieces are attacking the king?
    controlled_by_opponent = @opponent.controlled_squares
    number_of_attackers = controlled_by_opponent.count(king_coord)

    #Test for legal moves
    possible_moves = []

    #If only one attacker, can be captured or blocked(?)
    if number_of_attackers == 1
      attacker = @opponent.get_attacking_piece(king_coord)
      attacker_coords = attacker.get_xy


      #Capture the piece?
      for piece in @pieces
        if piece.legal_moves.include?(attacker_coords)
          next if piece.class.name == "King" and controlled_by_opponent.include?(attacker_coords)
          possible_moves << [piece.coords, attacker_coords]
        end
      end

      #Block the piece?
      if attacker.blockable?
        #Try to block that piece
        squares_on_line = attacker.line_of_sight(king_coord)
        for piece in @pieces
          next if piece.class.name == "King"
          for sq in squares_on_line
            if piece.legal_moves.include?(sq)
              possible_moves << [piece.get_xy, sq]
            end
          end
        end
      end

    end #End block for attackers = 1

    #Move the king
    for move in @king.legal_moves
      unless controlled_by_opponent.include?(move)
        possible_moves << [king_coord, move]
      end
    end

    #Mated
    if possible_moves.length == 0
      @board.resign(@color)
      return
    end

    loop do
      move = get_move

      if move.class.name == "String"
        puts "Cannot castle in check!"
        next
      end

      move = move.map { |sq| Coordinate.xy_from_alg(sq) }

      unless possible_moves.include?(move)
        puts "Cannot play that move."
        next
      end

      #This can be cleaned, I'm sure.

      src = move[0]
      dest = move[1]
      if @board.query(dest)
        unless @board.capture(src, dest)
          puts "That piece is pinned and cannot capture!"
          move = get_move
          next
        end
        @board.query(src).move(dest)
      else
        unless @board.move(src, dest)
          puts "That piece is pinned!"
          move = get_move
          next
        end
        @board.query(dest).move(dest)
      end
      break
    end

    @check = false
  end

  def in_check?
    return @check
  end

  def controlled_squares
    control = []
    for piece in @pieces
      # puts "Piece: #{piece.symbol} at #{piece.get_xy}; Controlled squares = #{piece.controlled_squares}"
      control.concat piece.controlled_squares
      # puts "total controlled: #{control}"
    end
    control
  end

  def get_attacking_piece(coord)
    for piece in @pieces
      return piece if piece.legal_moves.include?(coord)
    end
    nil
  end

  private

  def get_move
    puts "Enter a move (from to)"
    move = gets.chomp

    if move.downcase == "sss"
      save(@board)
      return get_move
    end

    if move.downcase == "qqq"
      exit
    end

    if move.downcase == "o-o" or move.downcase == "o-o-o"
      return move
    else
      move = move.split
    end

    until (move[0].match /^[a-hA-H][1-8]$/ and move[1].match /^[a-hA-H][1-8]$/)
      puts "That move is not valid. Try again."
      move = gets.chomp
      if move.downcase == "o-o" or move.downcase == "o-o-o"
        return move
      else
        move = move.split
      end
    end
    move
  end

  def find_piece(x_y)
    for piece in @pieces
      if piece.get_xy == x_y
        return piece
      end
    end
    nil
  end

  def save(board)
    slot = ""
    loop do
      puts "Enter save slot (1-9)"
      slot = gets.chomp
      unless slot.match /^[1-9]$/
        puts "Invalid slot"
        next
      end
      break
    end
    save_file = File.open("save_#{slot}", "w+")

    for move in board.moves
      if move == "o-o" or move == "o-o-o"
        save_file.write(move + "\n")
        next
      end
      save_file.write(move.join(":") + "\n")
    end

    save_file.close
  end

end
