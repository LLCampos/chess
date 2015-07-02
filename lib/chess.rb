require_relative 'pieces'
require 'pry'

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
    occupied_spaces('white') + occupied_spaces('black')
  end

  # checks if there is a empty space in the given position
  def empty_house?(position)
    board[position[0]][position[1]] == ' '
  end

  def move(from, to, color)
  end

end