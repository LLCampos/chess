class Piece
  attr_accessor :symbol, :color, :position, :type

  def initialize(symbol, color, type, position)
    @symbol = symbol
    @color = color
    @position = position
    @type = type
  end

  def possible_next_moves(all_occupied_spaces)
    case type
    when 'king'
      possible_next_moves_king(position)
    when 'queen'
      possible_next_moves_queen(position, all_occupied_spaces)
    when 'rook'
      possible_next_moves_rook(position, all_occupied_spaces)
    when 'bishop'
      possible_next_moves_bishop(position, all_occupied_spaces)
    when 'knight'
      possible_next_moves_knight(position)
    when 'pawn'
      possible_next_moves_pawn(position)
    end
  end

  def possible_next_moves_king(position)
    pm = []
    [-1, 0, 1].each do |line|
      [-1, 0, 1].each do |column|
        pm << [position[0] + line, position[1] + column]
      end
    end
    pm = legal_moves(position, pm)
  end


  def possible_next_moves_pawn(position)
  end

  def possible_next_moves_bishop(position)
    pm = []
    (-7..7).each do |n|
      pm << [position[0] + n, position[1] + n]
      pm << [position[0] - n, position[1] + n]
      pm << [position[0] + n, position[1] - n]
    end
    legal_moves(position, pm)
  end

  def possible_next_moves_rook(position, all_occupied_spaces)
    pm = []
    (1..7).each do |n|
      pm << [position[0], position[1] + n]
      pm << [position[0], position[1] - n]
      pm << [position[0] + n, position[1]]
      pm << [position[0] - n, position[1]]
    end
    legal_moves(position, pm)
    block_way_rook(pm.sort, position, all_occupied_spaces)
  end

  # group possible movments by position relative to piece (after in line, before in column...)
  def group_possible_moves_rook(pm, position)
    result = []

    result << pm.select do |p|
      p[0] == position[0] && p[1] < position[1]
    end

    result << pm.select do |p|
      p[0] == position[0] && p[1] > position[1]
    end

    result << pm.select do |p|
      p[1] == position[1] && p[0] < position[0]
    end

    result << pm.select do |p|
      p[1] == position[1] && p[0] > position[0]
    end
    result
  end

 # returns the limited possible movementes, considering that other pieces might be blocking the way
  def block_way_rook(pm, position, all_occupied_spaces)
    group_possible_moves_rook(pm, position).map do |lc|
      occupied = lc.select { |p| all_occupied_spaces.include?(p) }
      if (occupied.first <=> position) == 1
        lc.keep_if { |p| (p <=> occupied.first) < 1 }
      else
        lc.keep_if { |p| (p <=> occupied.first) > -1 }
      end
    end
  end

  def possible_next_moves_queen(position)
    possible_next_moves_rook(position) + possible_next_moves_bishop(position)
  end

  def possible_next_moves_knight(position)
    pm = []
    [-2, -1, 1, 2].each do |x|
      [-2, -1, 1, 2].each do |y|
        pm << [position[0] + x, position[1] + y] if x.abs != y.abs
      end
    end
    legal_moves(position, pm)
  end

  def legal_moves(position, pm)
    pm.uniq!
    pm.delete_if do |move|
      move == position || move[0] > 7 || move[1] > 7 || move[0] < 0 || move[1] < 0
    end
  end

end

