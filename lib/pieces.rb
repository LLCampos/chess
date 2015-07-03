require 'pry'

class Piece
  attr_accessor :symbol, :color, :position, :type, :n

  def initialize(symbol, color, type, position, n = 0)
    @symbol = symbol
    @color = color
    @position = position
    @type = type
    @n = n
  end

  def possible_next_moves(all_occupied_spaces)
    case type
    when 'king'
      possible_next_moves_king
    when 'queen'
      possible_next_moves_queen(all_occupied_spaces)
    when 'rook'
      possible_next_moves_rook(all_occupied_spaces)
    when 'bishop'
      possible_next_moves_bishop(all_occupied_spaces)
    when 'knight'
      possible_next_moves_knight
    when 'pawn'
      possible_next_moves_pawn(all_occupied_spaces)
    end
  end

  # returns the limited possible movements, considering that other pieces might be blocking the way
  def block_way(pm, all_occupied_spaces)
    pm.map do |lc|
      occupied = lc.select { |p| all_occupied_spaces.include?(p) }
      if occupied.empty?
        lc
      else
        lc.keep_if { |p| lc.index(p) <= lc.index(occupied.first) }
      end
    end
  end

  def possible_next_moves_king
    pm = []
    [-1, 0, 1].each do |line|
      [-1, 0, 1].each do |column|
        pm << [position[0] + line, position[1] + column]
      end
    end
    pm = legal_moves(pm)
  end

  def possible_next_moves_pawn_horiverti(all_occupied_spaces)
    front = []
    if color == 'black'
      front << [position[0] - 1, position[1]]
      front << [position[0] - 2, position[1]] if n == 1 && !all_occupied_spaces.include?([position[0] - 1, position[1]])
    else
      front << [position[0] + 1, position[1]]
      front << [position[0] + 2, position[1]] if n == 1 && !all_occupied_spaces.include?([position[0] + 1, position[1]])
    end
    legal_moves(front)
  end

  def possible_next_moves_pawn_diag
    diag = []
    if color == 'black'
      diag << [position[0] - 1, position[1] - 1]
      diag << [position[0] - 1, position[1] + 1]
    else
      diag << [position[0] + 1, position[1] - 1]
      diag << [position[0] + 1, position[1] + 1]
    end
    legal_moves(diag)
  end

  def possible_next_moves_pawn(all_occupied_spaces)
    [possible_next_moves_pawn_diag] + [possible_next_moves_pawn_horiverti(all_occupied_spaces)]
  end

  def possible_next_moves_bishop(all_occupied_spaces)
    pm = []
    (-7..7).each do |n|
      pm << [position[0] + n, position[1] + n]
      pm << [position[0] - n, position[1] + n]
      pm << [position[0] + n, position[1] - n]
    end
    pm = legal_moves(pm)
    pm = group_possible_moves_bishop(pm.sort)
    block_way(pm, all_occupied_spaces).flatten(1).sort
  end

  # group possible movments by position relative to piece
  def group_possible_moves_bishop(pm)
    result = []

    result << pm.select do |p|
      p[0] < position[0] && p[1] < position[1]
    end

    result << pm.select do |p|
      p[0] < position[0] && p[1] > position[1]
    end

    result << pm.select do |p|
      p[0] > position[0] && p[1] < position[1]
    end

    result << pm.select do |p|
      p[0] > position[0] && p[1] > position[1]
    end
    result[0].reverse!
    result[1].reverse!
    result
  end

  def possible_next_moves_rook(all_occupied_spaces)
    pm = []
    (1..7).each do |n|
      pm << [position[0], position[1] + n]
      pm << [position[0], position[1] - n]
      pm << [position[0] + n, position[1]]
      pm << [position[0] - n, position[1]]
    end
    pm = legal_moves(pm)
    pm = group_possible_moves_rook(pm.sort)
    block_way(pm, all_occupied_spaces).flatten(1).sort
  end

  # group possible movments by position relative to piece (after in line, before in column...)
  def group_possible_moves_rook(pm)
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
    result[0].reverse!
    result[2].reverse!
    result
  end



  def possible_next_moves_queen
    possible_next_moves_rook(all_occupied_spaces) + possible_next_moves_bishop(all_occupied_spaces)
  end

  def possible_next_moves_knight
    pm = []
    [-2, -1, 1, 2].each do |x|
      [-2, -1, 1, 2].each do |y|
        pm << [position[0] + x, position[1] + y] if x.abs != y.abs
      end
    end
    legal_moves(pm)
  end

  def legal_moves(pm)
    pm.uniq!
    pm.delete_if do |move|
      move == position || move[0] > 7 || move[1] > 7 || move[0] < 0 || move[1] < 0
    end
  end

end

