describe Grid do
  context "initialization" do
    # it's an easy sudoku puzzle, row by row
    let(:puzzle) { '015003002000100906270068430490002017501040380003905000900081040860070025037204600' }
    let(:grid) { Grid.new(puzzle) }
    it 'should have 81 cells' do
      expect(grid.num_string.length).to eq(81)
    end
    it 'should have an unsolved first cell' do
      expect(num_string[0]).to eq(puzzle[0])
    end
    it 'should have a solved second cell with value 1' do
      expect(num_string[1].to eq(puzzle[1])
    end
  end
end
