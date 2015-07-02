require 'chess.rb'

describe '#occupied_spaces'  do

  context 'only two white pieces on the board' do
    before do
      @two = ChessGame.new
      @two.board = [[' '] * 8,
                    [' '] * 8,
                    [Piece.new("\u2659", 'white', 'pawn', [2, 0])] + [' '] * 7,
                    [' '] * 8,
                    [' '] * 8,
                    [Piece.new("\u2659", 'white', 'pawn', [5, 0])] + [' '] * 7,
                    [' '] * 8,
                    [' '] * 8]
    end

    it 'returns the right position of the pieces on the board' do
      expect(@two.occupied_spaces('white').sort).to eql([[2, 0], [5, 0]])
    end
  end


end