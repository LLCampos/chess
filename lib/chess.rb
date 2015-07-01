class Piece

  def initialize(symbol, color, type, position)
    @symbol = symbol
    @color = color
    @position = position
    @possible_moves = possible_moves(type, position)
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
end


class ChessGame
  def initialize
  end
end




w_king = "\u2654"
w_queen = "\u2655"
w_rook = "\u2656"
w_bishop = "\u2657"
w_knight = "\u2658"
w_pawn = "\u2659"
b_king = "\u265A"
b_queen = "\u265B"
b_rook = "\u265C"
b_bishop = "\u265D"
b_knight = "\u265E"
b_pawn = "\u2659F"