require_relative 'cell'

class Grid2

  SIZE = 81
  attr_reader :values, :cells, :solutions

  def initialize(puzzle)
    @cells = puzzle.split('').map { |value| Cell.new(value) }
    @values = ['1','2','3','4','5','6','7','8','9']
  end

  def num_string
    cells.map { |cell| cell.value }.join
  end

  def unfilled_cells(string)
    string.split('').count { |i| i == '0' }
  end

  def solve
    outstanding_before, looping = SIZE, false
    while !solved? && !looping
      easy_solve # ask each cell to solve itself
      outstanding         = @cells.count {|c| !c.filled? }
      looping             = outstanding_before == outstanding
      outstanding_before  = outstanding
    end
    hard_solve unless solved?
  end

  def easy_solve
    cells.each_with_index { |cell, index|
      unless cell.filled?
        cands = candidates_at(index)
        cell.value = cands[0] if cands.length == 1
        p num_string
      end
    }
  end

  def hard_solve
    cells.each_with_index { |cell, index|
      unless cell.filled?
        cands = candidates_at(index)
        cands.each { |guess|
          cell.value = guess
          new_grid = Grid2.new(num_string)
          new_grid.solve
          p "solved: #{new_grid.num_string}" and return if new_grid.solved?
        }
      end
    }

  end

  def solved?
    !num_string.include?('0')
  end

  private

  def candidates_at(index)
    values - get_row(index) - get_column(index) - get_box(index)
  end

  def boxes_by_index
  [0, 3, 6, 27, 30, 33, 54, 57, 60].map { |i|
    [ i,    i+1,  i+2,
      i+9,  i+10, i+11,
      i+18, i+19, i+20 ]
    }
  end

  def row_by_index
  [0, 9, 18, 27, 36, 45, 54, 63, 72].map { |i|
    [ i,    i+1,  i+2,
      i+3,  i+4,  i+5,
      i+6,  i+7,  i+8 ]
    }
  end

  def column_by_index
  [0, 1, 2, 3, 4, 5, 6, 7, 8].map { |i|
    [ i,    i+9,  i+18,
      i+27, i+36, i+45,
      i+54, i+63, i+72 ]
    }
  end

  def get_box(index)
    box = boxes_by_index.select { |box| box.include?(index) }
    box.flatten.map { |i| num_string[i] }
  end

  def get_row(index)
    row = row_by_index.select { |row| row.include?(index) }
    row.flatten.map { |i| num_string[i] }
  end

  def get_column(index)
    column = column_by_index.select { |column| column.include?(index) }
    column.flatten.map { |i| num_string[i] }
  end

end
