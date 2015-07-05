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

              [Piece.new("\u265F", 'white', 'pawn', [1, 0], 1),
               Piece.new("\u265F", 'white', 'pawn', [1, 1], 1),
               Piece.new("\u265F", 'white', 'pawn', [1, 2], 1),
               Piece.new("\u265F", 'white', 'pawn', [1, 3], 1),
               Piece.new("\u265F", 'white', 'pawn', [1, 4], 1),
               Piece.new("\u265F", 'white', 'pawn', [1, 5], 1),
               Piece.new("\u265F", 'white', 'pawn', [1, 6], 1),
               Piece.new("\u265F", 'white', 'pawn', [1, 7], 1)],

              [' '] * 8,
              [' '] * 8,
              [' '] * 8,
              [' '] * 8,

              [Piece.new("\u2659", 'black', 'pawn', [6, 0], 1),
               Piece.new("\u2659", 'black', 'pawn', [6, 1], 1),
               Piece.new("\u2659", 'black', 'pawn', [6, 2], 1),
               Piece.new("\u2659", 'black', 'pawn', [6, 3], 1),
               Piece.new("\u2659", 'black', 'pawn', [6, 4], 1),
               Piece.new("\u2659", 'black', 'pawn', [6, 5], 1),
               Piece.new("\u2659", 'black', 'pawn', [6, 6], 1),
               Piece.new("\u2659", 'black', 'pawn', [6, 7], 1)],

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
    nil
  end

  def other_color(color)
    color == 'white' ? 'black' : 'white'
  end

  # checks if there is a empty space in the given position
  def empty_house?(position)
    board[position[0]][position[1]] == ' '
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


  # returns true if the piece choosen is blocked and can't move
  def legal_from_1?(from, color)
    piece = board[from[0]][from[1]]
    pnm = piece.possible_next_moves(all_occupied_spaces)
    if piece.type == 'pawn'
      legal_from_1_pawn?(color, pnm)
    else
      pnm.length != 0 && !pnm.map { |p| board[p[0]][p[1]] == ' ' ? ' ' : board[p[0]][p[1]].color }.all? { |p| p == color }
    end
  end

  # returns true if pawn can move
  def legal_from_1_pawn?(color, pnm)
    result = false
    pnm[0].each do |p|
      result = true if occupied_spaces(other_color(color)).include?(p)
    end
    result = true if board[pnm[1][0][0]][pnm[1][0][1]] == ' '
    result
  end

  # returns true if there is a piece of the player's color on the position she has choosen
  def legal_from_2?(from, color)
    occupied_spaces(color).include?(from)
  end

  # returns false if the player is trying to move the piece to a position where already his a piece of the player's color
  def legal_to_1?(to, color)
    !occupied_spaces(color).include?(to)
  end

  # returns true if the move payer wants to make is legal considering the piece choosen
  def legal_to_2?(to, from)
    piece = board[from[0]][from[1]]
    if piece.type == 'pawn'
      move_legality_pawn(to, piece)
    else
      piece.possible_next_moves(all_occupied_spaces).include?(to)
    end
  end

  # returns true if the player is trying to move the pawn to a legal position
  def move_legality_pawn(to, piece)
    diagonals_possible = piece.possible_next_moves(all_occupied_spaces)[0]
    front_possible = piece.possible_next_moves(all_occupied_spaces)[1]
    ((diagonals_possible.include?(to) && all_occupied_spaces.include?(to)) || (front_possible.include?(to) && board[to[0]][to[1]] == ' '))
  end

 # move piece from -> to
  def move(from, to, left_behind = ' ')
    piece = board[from[0]][from[1]]
    piece.position = [to[0], to[1]]
    piece.n = 0
    board[from[0]][from[1]] = left_behind
    board[to[0]][to[1]] = piece
  end


  # returns an array with all possible positions, except fron moves of pawns, of ALL the pieces that are of the color given in the argument
  def total_all_possible_moves(color, n = 0)
    result = []
    board.each do |line|
      line.each do |p|
        unless p == ' ' || p.color != color
          if p.type == 'pawn' && n == 0
            result << p.possible_next_moves(all_occupied_spaces)[0]
          else
            result << p.possible_next_moves(all_occupied_spaces)
          end
        end
      end
    end
    result = result.flatten(1).uniq.delete_if do |p|
      occupied_spaces(color).include?(p)
    end
    result
  end

  # returns true if the king can make some movement without being in a check-mate position
  def can_king_move?(from, color)
    result = false
    piece = board[from[0]][from[1]]
    if piece.type == 'king'
      pnm = piece.possible_next_moves(all_occupied_spaces).delete_if do |p|
        board[p[0]][p[1]] != ' ' && board[p[0]][p[1]].color == color
      end
      pnm.each do |p|
        result = true unless total_all_possible_moves(other_color(color)).include?(p)
      end
      result
    else
      true
    end
  end

  # returns true if the king can move to that position
  def can_king_move_to?(color, from, to)
    result = true
    piece = board[from[0]][from[1]]
    if piece.type == 'king'
      result = false if total_all_possible_moves(other_color(color)).include?(to)
      result
    else
      true
    end
  end

  # returns true if the king of the color given in the argument is in check
  def check?(color)
    board.each do |line|
      a = line.find do |p|
        p != ' ' && p.type == 'king' && p.color == color
      end
      @king_position = a.position unless a.nil?
    end
    total_all_possible_moves(other_color(color)).include?(@king_position)
  end

  # returns an array with all pieces of the color given in the argument
  def all_pieces(color)
    pieces = []
    board.each do |line|
      line.find do |p|
        pieces << p if p != ' ' &&  p.color == color
      end
    end
    pieces
  end

  # helper method of checkmate method
  def test_move(piece, piece_initial_position, piece_movement, movement, color)
    result = true
    move(piece_initial_position, movement)
    result = false unless check?(color)
    move(movement, piece_initial_position, piece_movement)
    board[piece_initial_position[0]][piece_initial_position[1]].n = 1 if piece.n == 1
    result
  end


  # returns true if the king of the color given in the argument is in checkmate
  def checkmate?(colour)
    result = true
    pieces = all_pieces(colour)
    pieces.each do |piece|
      pnm = piece.possible_next_moves(all_occupied_spaces)
      if piece.type == 'pawn'
        pnm.flatten!(1)
        pnm = pnm.keep_if { |to| move_legality_pawn(to, piece) }
      end
      pnm = pnm.delete_if { |p| occupied_spaces(colour).include?(p) }
      pnm.each do |movement|
        piece_initial_position = piece.position
        piece_movement = board[movement[0]][movement[1]]
        result = false if test_move(piece, piece_initial_position, piece_movement, movement, colour) == false
      end
    end
    result
  end
end

