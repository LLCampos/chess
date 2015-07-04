require_relative 'chess'

class Game
  attr_accessor :chess_game
  def initialize
    @chess_game = ChessGame.new
  end

  def show
    @chess_game.show
  end


  def turn(color)
    from = ask_from(color)
    to = ask_to(color, from)
    chess_game.move(from, to)
  end

  def ask(to_or_from, color)
    if to_or_from == 'from'
      puts 'Which piece do you want to move?'
    else
      puts 'Where do you to move your piece to?'
    end
    print 'Line: '
    line = gets.chomp.to_i - 1
    print 'Column: '
    column = gets.chomp.to_i - 1
    unless (0..7).include?(line) && (0..7).include?(column)
      puts 'You have to choose positions between 1 and 8!'
      if to_or_from == 'from'
        ask_from(color)
      else
        ask_to(color)
      end
    end
    [line, column]
  end

  def ask_from(color)
    from = ask('from', color)
    if chess_game.empty_house?(from)
      puts 'There\' no piece in there!'
      ask_from(color)
    elsif  !chess_game.legal_from_1?(from, color)
      puts "You can't move that piece!"
      ask_from(color)
    elsif !chess_game.legal_from_2?(from, color)
      puts "There isnt a #{color} piece in that position!"
      ask_from(color)
    elsif !chess_game.can_king_move?(from, color)
      puts "You can't move your king!"
      ask_from(color)
    else
      from
    end
  end

  def ask_to(color, from)
    to = ask('to', color)
    if !chess_game.legal_to_1?(to, color)
      puts "There is already a #{color} piece in that position!"
      ask_to(color, from)
    elsif !chess_game.legal_to_2?(to, from)
      puts "Your piece can't move to that position!"
      ask_to(color, from)
    elsif !chess_game.can_king_move_to?(color, from, to)
      puts "You can't move your king to that position! I  would be a check-mate!"
      ask_to(color, from)
    else
      to
    end
  end



end

def initial_message
  puts 'Welcome to RubyChess! Player 1 will play with the black pieces, Player 2 with the white ones!'
end


def start_game
  game = Game.new
  initial_message
  puts "\n\n"
  puts 'Player 1 goes first!'
  loop do
    puts "\n\n"
    game.show
    puts "\n\n"
    game.turn('black')
    puts "\n\n"
    puts 'Player\'s 2 turn!'
    puts "\n\n"
    game.show
    puts "\n\n"
    game.turn('white')
    puts "\n\n"
    puts 'Player\'s 1 turn!'
  end
end