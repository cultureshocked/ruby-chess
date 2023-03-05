require "./lib/board.rb"
require "./lib/player.rb"

describe "board.rb" do
  describe "#query(x_y)" do

    it "returns nil for an empty square supplied by array" do
      p_one = Player.new(0)
      p_two = Player.new(1)
      board = Board.new(p_one, p_two)
      expect(board.query([4, 4])).to eql(nil)
    end

    it "returns nil for an empty square supplied by Coordinate" do
      p_one = Player.new(0)
      p_two = Player.new(1)
      board = Board.new(p_one, p_two)
      coord = Coordinate.new(4, 4)
      expect(board.query(coord)).to eql(nil)
    end

    it "returns piece on square supplied by array" do
      p_one = Player.new(0)
      p_two = Player.new(1)
      board = Board.new(p_one, p_two)
      expect(board.query([0, 1]).class.name).to eql("Pawn")
    end

    it "returns piece on square supplied by array" do
      p_one = Player.new(0)
      p_two = Player.new(1)
      board = Board.new(p_one, p_two)
      coord = Coordinate.new(0, 1)
      expect(board.query(coord).class.name).to eql("Pawn")
    end
  end
end
