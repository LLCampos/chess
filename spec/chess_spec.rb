require 'chess.rb'

describe 'ChessGame' do
  before :each do
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

  describe '#check?' do

    context 'when king is not in check' do
      it 'returns false' do
        expect(@board.check?('black')).to eql(false)
        expect(@board.check?('white')).to eql(false)
      end
    end

    context 'when king is in check' do
      before do
        @board.move([1,2], [2,2])
        @board.move([7,2], [3,0])
      end
      it "returns true" do
        expect(@board.check?('white')).to eq(true)
      end
    end
  end

  describe '#checkmate?' do

    context 'king in checkmate position' do
      before do
        @board.move([1, 2], [2, 2])
        @board.move([7, 2], [3, 0])
      end
      it 'returns true' do
        expect(@board.checkmate?('white')).to eql(true)
      end


    end


    context 'not a checkmate' do
      it 'returns false' do
        expect(@board.checkmate?('black')).to eql(false)
        expect(@board.checkmate?('white')).to eql(false)
      end
      before do
        @board.move([7, 4], [3, 1])
        @board.move([1, 3], [1, 5])
        @board.move([0, 3], [1, 3])
        @board.move([7, 1], [4, 4])
      end
      it 'returns false' do
        expect(@board.checkmate?('white')).to eq(false)
      end
    end


  end




end

describe 'Pieces' do

  describe '#possible_next_moves_bishop' do
      before do
        @bishop = Piece.new("\u265D", 'white', 'bishop', [4, 3])
        @occupied_spaces = [[2,1],[3,2],[2,5],[0,7],[5,2],[7,0],[7,6]]
      end

      it 'return the right set of possible moves' do
        expect(@bishop.possible_next_moves(@occupied_spaces)).to eql([[3, 2], [2, 5], [3, 4], [5, 2], [5, 4], [6, 5], [7, 6]].sort)
      end

  end

  describe '#possible_next_moves_rook' do
      before do
        @rook = Piece.new("\u265D", 'white', 'rook', [4, 3])
        @occupied_spaces = [[4, 1], [4, 5], [4, 6], [7, 3], [3, 3]]
      end

      it 'return the right set of possible moves' do
        expect(@rook.possible_next_moves(@occupied_spaces)).to eql([[4, 1], [4, 2], [4, 4], [4, 5], [5, 3], [6, 3], [7, 3], [3, 3]].sort)
      end


  end




end
