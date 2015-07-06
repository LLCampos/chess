require_relative 'chess'
require 'yaml'
require 'pry'

class Game
  attr_accessor :chess_game, :turn
  def initialize
    @chess_game = ChessGame.new
    @player_turn = 'black'
  end

  def show
    @chess_game.show
  end

  def save_game(file)
    yaml = YAML::dump(self)
    File.open("#{file}.yaml", "w") { |f| f.write(yaml) }
  end

  def del_temp
    File.delete("temp.yaml")
  end

  def load(file)
    game_file = File.open("#{file}.yaml", 'r') { |f| f.read }
    YAML::load(game_file)
  end

  def turns
    loop do
      show
      puts "\n\n"
      puts "#{@player_turn.capitalize} pieces turn!"
      puts "\n\n"
      turn(@player_turn)
    end
  end

  def checkmate(color)
    show
    puts "Checkmate! #{color.capitalize} pieces win the game!"
    start_game
  end

  def self_check
    puts "You can't move your piece to that place. It would be check for you!"
    game = load('temp')
    game.turns
  end


  def turn(color)
    save_game('temp')
    from = ask_from(color)
    to = ask_to(color, from)
    chess_game.move(from, to)
    if chess_game.check?(color)
      self_check
    elsif chess_game.checkmate?(other_color(color))
      checkmate(color)
    end
    @player_turn = other_color(color)
    del_temp
  end

  def ask(to_or_from, color, f = [])
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
        ask_to(color, f)
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
    to = ask('to', color, from)
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
  puts 'Welcome to RubyChess!'
  puts 'In RubyChess, black pieces go first!'
end


def start_game
  game = Game.new
  initial_message
  puts "\n\n"
  game.turns
end