class GameBoard
  attr_accesor :board,:rows,:columns
  def initialize
    @board=[]
    10.times {@board << []}
    @rows=10
    @columns=10
  end
end
