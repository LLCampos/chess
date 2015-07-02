require 'chess.rb'

describe 'ChessGame' do
  before :all do
    @board = ChessGame.new
  end

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

  describe '#move_legality' do

    context 'when trying to move towers to a ilegal position do'

      it 'returns false' do
        expect(@board.move_legality([7, 7], [4, 7], 'black')).to eql(false)
        expect(@board.move_legality([7, 0], [7, 2], 'black')).to eql(false)
        expect(@board.move_legality([0, 0], [4, 0], 'white')).to eql(false)
        expect(@board.move_legality([0, 7], [4, 7], 'white')).to eql(false)
      end

    end

    context 'when trying to move horses to legal position' do

      it 'returns true' do
        expect(@board.move_legality([7, 6], [5, 7], 'black')).to eql(true)
        expect(@board.move_legality([7, 1], [5, 2], 'black')).to eql(true)
        expect(@board.move_legality([0, 1], [2, 0], 'white')).to eql(true)
        expect(@board.move_legality([0, 6], [2, 5], 'white')).to eql(true)
      end

    end

end
