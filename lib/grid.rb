require_relative 'cell'

class Grid

  attr_reader :values, :cells

  def initialize(puzzle)
    @cells = puzzle.split('').map { |value| Cell.new(value) }
    @values = ['1','2','3','4','5','6','7','8','9']
  end

  def num_string
    cells.map { |cell| cell.value }.join
  end

  def solve
    cells.each_with_index { |cell, index|
      unless cell.filled?
        candidates = values - get_row(index) - get_column(index) - get_box(index)
        if candidates.length == 1
          cell.value = candidates[0]
        end
      end
    }
    solved? ? (p "solved #{num_string}") : solve
  end

  def solved?
    !num_string.include?('0')
  end

  private

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
    box2 = boxes_by_index.select { |box| box.include?(index) }
    box2.flatten.map { |i| num_string[i] }
  end

  def get_row(index)
    row2 = row_by_index.select { |row| row.include?(index) }
    row2.flatten.map { |i| num_string[i] }
  end

  def get_column(index)
    column2 = column_by_index.select { |column| column.include?(index) }
    column2.flatten.map { |i| num_string[i] }
  end

end
