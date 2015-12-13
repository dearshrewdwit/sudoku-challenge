require './lib/grid2'


describe Grid2 do

  context "initialization" do
    # it's an easy sudoku puzzle, row by row
    let(:puzzle) { '015003002000100906270068430490002017501040380003905000900081040860070025037204600' }
    let(:grid) { Grid2.new(puzzle) }

    it 'should have 81 cells' do
      expect(grid.num_string.length).to eq(81)
    end

    it 'should have an unsolved first cell' do
      expect(grid.num_string[0]).to eq(puzzle[0])
    end

    it 'should have a solved second cell with value 1' do
      expect(grid.num_string[1]).to eq(puzzle[1])
    end
  end

  context "solving easy sudoku" do

    let(:puzzle) { '015003002000100906270068430490002017501040380003905000900081040860070025037204600' }
    let(:grid) { Grid2.new(puzzle) }

    it "can solve the puzzle" do
      expect(grid.solved?).to be_falsey
      grid.solve
      expect(grid.solved?).to be_truthy
      expect(grid.num_string).to eq('615493872348127956279568431496832517521746389783915264952681743864379125137254698')
    end
  end

  context "solving hard sudoku" do

    let(:puzzle) { "800000000003600000070090200050007000000045700000100030001000068008500010090000400" }
    let(:grid) { Grid2.new(puzzle) }

    xit "can solve the puzzle" do
      expect(grid.solved?).to be_falsey
      grid.solve
      expect(grid.solved?).to be_truthy
      expect(grid.num_string).to eq('')
    end
  end


end
