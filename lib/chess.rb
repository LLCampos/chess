require_relative "pieces"

class ChessGame
  def initialize
    @board = [
                [Piece.new(@b_rook, 'black', 'rook', [0, 0]),
                 Piece.new(@b_knight, 'black', 'knight', [0, 1]),
                 Piece.new(@b_bishop, 'black', 'bishop', [0, 2]),
                 Piece.new(@b_king, 'black', 'king', [0, 3]),
                 Piece.new(@b_queen, 'black', 'queen', [0, 4]),
                 Piece.new(@b_bishop, 'black', 'bishop', [0, 5]),
                 Piece.new(@b_knight, 'black', 'knight', [0, 6]),
                 Piece.new(@b_rook, 'black', 'rook', [0, 7])],

                [Piece.new(@b_pawn, 'black', 'pawn', [1, 0]),
                 Piece.new(@b_pawn, 'black', 'pawn', [1, 1]),
                 Piece.new(@b_pawn, 'black', 'pawn', [1, 2]),
                 Piece.new(@b_pawn, 'black', 'pawn', [1, 3]),
                 Piece.new(@b_pawn, 'black', 'pawn', [1, 4]),
                 Piece.new(@b_pawn, 'black', 'pawn', [1, 5]),
                 Piece.new(@b_pawn, 'black', 'pawn', [1, 6]),
                 Piece.new(@b_pawn, 'black', 'pawn', [1, 7])],

                [' '] * 8,
                [' '] * 8,
                [' '] * 8,
                [' '] * 8,

                [Piece.new(@w_pawn, 'white', 'pawn', [6, 0]),
                 Piece.new(@w_pawn, 'white', 'pawn', [6, 1]),
                 Piece.new(@w_pawn, 'white', 'pawn', [6, 2]),
                 Piece.new(@w_pawn, 'white', 'pawn', [6, 3]),
                 Piece.new(@w_pawn, 'white', 'pawn', [6, 4]),
                 Piece.new(@w_pawn, 'white', 'pawn', [6, 5]),
                 Piece.new(@w_pawn, 'white', 'pawn', [6, 6]),
                 Piece.new(@w_pawn, 'white', 'pawn', [6, 7])],

                [Piece.new(@w_rook, 'white', 'rook', [7, 0]),
                 Piece.new(@w_knight, 'white', 'knight', [7, 1]),
                 Piece.new(@w_bishop, 'white', 'bishop', [7, 2]),
                 Piece.new(@w_king, 'white', 'king', [7, 3]),
                 Piece.new(@w_queen, 'white', 'queen', [7, 4]),
                 Piece.new(@w_bishop, 'white', 'bishop', [7, 5]),
                 Piece.new(@w_knight, 'white', 'knight', [7, 6]),
                 Piece.new(@w_rook, 'white', 'rook', [7, 7])]
             ]
  end

  def show
    @board.each do |line|
      puts '| ' + line.join(' | ') + ' |'
    end
  end
end




@w_king = "\u2654"
@w_queen = "\u2655"
@w_rook = "\u2656"
@w_bishop = "\u2657"
@w_knight = "\u2658"
@w_pawn = "\u2659"
@b_king = "\u265A"
@b_queen = "\u265B"
@b_rook = "\u265C"
@b_bishop = "\u265D"
@b_knight = "\u265E"
@b_pawn = "\u2659F"