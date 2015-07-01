require_relative "pieces"

class ChessGame
  attr_accessor :board

  def initialize
    @board = [
                [Piece.new("\u265C", 'black', 'rook', [0, 0]),
                 Piece.new("\u265E", 'black', 'knight', [0, 1]),
                 Piece.new("\u265D", 'black', 'bishop', [0, 2]),
                 Piece.new("\u265A", 'black', 'king', [0, 3]),
                 Piece.new("\u265B", 'black', 'queen', [0, 4]),
                 Piece.new("\u265D", 'black', 'bishop', [0, 5]),
                 Piece.new("\u265E", 'black', 'knight', [0, 6]),
                 Piece.new("\u265C", 'black', 'rook', [0, 7])],

                [Piece.new("\u265F", 'black', 'pawn', [1, 0]),
                 Piece.new("\u265F", 'black', 'pawn', [1, 1]),
                 Piece.new("\u265F", 'black', 'pawn', [1, 2]),
                 Piece.new("\u265F", 'black', 'pawn', [1, 3]),
                 Piece.new("\u265F", 'black', 'pawn', [1, 4]),
                 Piece.new("\u265F", 'black', 'pawn', [1, 5]),
                 Piece.new("\u265F", 'black', 'pawn', [1, 6]),
                 Piece.new("\u265F", 'black', 'pawn', [1, 7])],

                [' '] * 8,
                [' '] * 8,
                [' '] * 8,
                [' '] * 8,

                [Piece.new("\u2659", 'white', 'pawn', [6, 0]),
                 Piece.new("\u2659", 'white', 'pawn', [6, 1]),
                 Piece.new("\u2659", 'white', 'pawn', [6, 2]),
                 Piece.new("\u2659", 'white', 'pawn', [6, 3]),
                 Piece.new("\u2659", 'white', 'pawn', [6, 4]),
                 Piece.new("\u2659", 'white', 'pawn', [6, 5]),
                 Piece.new("\u2659", 'white', 'pawn', [6, 6]),
                 Piece.new("\u2659", 'white', 'pawn', [6, 7])],

                [Piece.new("\u2656", 'white', 'rook', [7, 0]),
                 Piece.new("\u2658", 'white', 'knight', [7, 1]),
                 Piece.new("\u2657", 'white', 'bishop', [7, 2]),
                 Piece.new("\u2654", 'white', 'king', [7, 3]),
                 Piece.new("\u2655", 'white', 'queen', [7, 4]),
                 Piece.new("\u2657", 'white', 'bishop', [7, 5]),
                 Piece.new("\u2658", 'white', 'knight', [7, 6]),
                 Piece.new("\u2656", 'white', 'rook', [7, 7])]
             ]
  end

  def show
    puts '   ' + (1..8).to_a.join('  ')
    board.each_with_index do |line, nline|
      line_symbol = line.map { |position| position == ' ' ? ' ' : position.symbol }
      puts "#{nline + 1} |" + line_symbol.join(' |') + ' |'
    end
  end

end




