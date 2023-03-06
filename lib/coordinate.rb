class Coordinate

  attr_reader :x, :y, :hash

  def initialize(x, y)
    @x = x
    @y = y
    @hash = [x: x, y: y]
  end

  def algebraic
    return "#{"abcdefgh".split("")[@x]}#{(@y - 8).abs}"
  end

  def x_y
    return [@x, @y]
  end

  def update(new_coord)
    @x = new_coord[0]
    @y = new_coord[1]
    @hash = [x: @x, y: @y]
  end

  def self.xy_from_alg(str)
    return nil unless str.match /^[a-hA-H][1-8]$/
    return [
      "abcdefgh"
        .split("")
        .find_index(str[0].downcase),
      (str[1].to_i - 8).abs
    ]
  end

  def self.alg_from_xy(x_y)
    return nil unless x_y[0].between?(0, 7) and x_y[1].between?(0, 7)
    return "#{"abcdefgh".find_index(x_y[0])}#{(y - 8).abs}"
  end

end
