class Cell

  attr_reader :candidates
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def filled?
    value != '0'
  end

end
