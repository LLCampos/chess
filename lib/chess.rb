require_relative 'pieces'
require 'pry'

class ChessGame
  attr_accessor :board

  def initialize
    @board = [
              [Piece.new("\u265C", 'white', 'rook', [0, 0]),
               Piece.new("\u265E", 'white', 'knight', [0, 1]),
               Piece.new("\u265D", 'white', 'bishop', [0, 2]),
               Piece.new("\u265A", 'white', 'king', [0, 3]),
               Piece.new("\u265B", 'white', 'queen', [0, 4]),
               Piece.new("\u265D", 'white', 'bishop', [0, 5]),
               Piece.new("\u265E", 'white', 'knight', [0, 6]),
               Piece.new("\u265C", 'white', 'rook', [0, 7])],

              [Piece.new("\u265F", 'white', 'pawn', [1, 0]),
               Piece.new("\u265F", 'white', 'pawn', [1, 1]),
               Piece.new("\u265F", 'white', 'pawn', [1, 2]),
               Piece.new("\u265F", 'white', 'pawn', [1, 3]),
               Piece.new("\u265F", 'white', 'pawn', [1, 4]),
               Piece.new("\u265F", 'white', 'pawn', [1, 5]),
               Piece.new("\u265F", 'white', 'pawn', [1, 6]),
               Piece.new("\u265F", 'white', 'pawn', [1, 7])],

              [' '] * 8,
              [' '] * 8,
              [' '] * 8,
              [' '] * 8,

              [Piece.new("\u2659", 'black', 'pawn', [6, 0]),
               Piece.new("\u2659", 'black', 'pawn', [6, 1]),
               Piece.new("\u2659", 'black', 'pawn', [6, 2]),
               Piece.new("\u2659", 'black', 'pawn', [6, 3]),
               Piece.new("\u2659", 'black', 'pawn', [6, 4]),
               Piece.new("\u2659", 'black', 'pawn', [6, 5]),
               Piece.new("\u2659", 'black', 'pawn', [6, 6]),
               Piece.new("\u2659", 'black', 'pawn', [6, 7])],

              [Piece.new("\u2656", 'black', 'rook', [7, 0]),
               Piece.new("\u2658", 'black', 'knight', [7, 1]),
               Piece.new("\u2657", 'black', 'bishop', [7, 2]),
               Piece.new("\u2654", 'black', 'king', [7, 3]),
               Piece.new("\u2655", 'black', 'queen', [7, 4]),
               Piece.new("\u2657", 'black', 'bishop', [7, 5]),
               Piece.new("\u2658", 'black', 'knight', [7, 6]),
               Piece.new("\u2656", 'black', 'rook', [7, 7])]
             ]
  end

  # shows the board
  def show
    puts '   ' + (1..8).to_a.join('  ')
    board.each_with_index do |line, nline|
      line_symbol = line.map { |position| position == ' ' ? ' ' : position.symbol }
      puts "#{nline + 1} |" + line_symbol.join(' |') + ' |'
    end
  end

  # returns all the spaces on the board that are occupied with a piece of color 'color'
  def occupied_spaces(colour)
    result = []
    board.each do |line|
      line = line.select { |house| house.class == Piece && house.color == colour }
      result << line.map(&:position)
    end
    result.flatten(1)
  end

  # returns all the spaces on the board that are occupied
  def all_occupied_spaces
    occupied_spaces('black') + occupied_spaces('white')
  end

  # checks if there is a empty space in the given position
  def empty_house?(position)
    board[position[0]][position[1]] == ' '
  end

  def move_legality(from, to, color)
    occupied_spaces(color).include?(from) && !occupied_spaces(color).include?(to) && board[from[0]][from[1]].possible_next_moves(all_occupied_spaces).include?(to)
  end

  #def move(from, to)
  #  piece  = board[from[0]][from[1]]
  #  piece.position = [to[0], to[1]]
  #  board[from[0]][from[1]] = ' '
  #  board[to[0]][to[1]] = piece
  #end

end

# turn
# Which move do you want to make?
# move_legality
# move