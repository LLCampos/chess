class Piece

  def initialize(symbol, color, type, position)
    @symbol = symbol
    @color = color
    @position = position
    @possible_moves = possible_moves(type, position)
  end


end

def possible_moves(type, position)
  case type
  when king
    possible_moves_king(position)
  when queen
    possible_moves_queen(position)
  when rook
    possible_moves_rook(position)
  when bishop
    possible_moves_bishop(position)
  when knight
    possible_moves_knight(position)
  when pawn
    possible_moves_pawn(position)
  end
end

def possible_moves_king(position)
  pm = []
  [-1, 0, 1].each do |line|
    [-1, 0, 1].each do |column|
      pm << [position[0] + line, position[1] + column]
    end
  end
  legal_moves(position, pm)
end

def possible_moves_pawn(position)
end

def possible_moves_bishop(position)
  pm = []
  (-7..7).each do |n|
    pm << [position[0] + n, position[1] + n]
    pm << [position[0] - n, position[1] + n]
    pm << [position[0] + n, position[1] - n]
  end
  legal_moves(position, pm)
end

def possible_moves_rook(position)
  pm = []
  (1..7).each do |n|
    pm << [position[0], position[1] + n]
    pm << [position[0], position[1] - n]
    pm << [position[0] + n, position[1]]
    pm << [position[0] - n, position[1]]
  end
  legal_moves(position, pm)
end

def possible_moves_queen(position)
  possible_moves_rook(position) + possible_moves_bishop(position)
end

def possible_moves_knight(position)
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
