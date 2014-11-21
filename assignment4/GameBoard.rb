class GameBoard
  attr_accessor :board,:rows,:columns
  def initialize
    @board=[]
    10.times {@board << []}
    @rows=10
    @columns=10
  end

  def full?(column)
    return @board[column].length==10
  end

  def height(column)
    return @board[column].length
  end

  def draw?
    draw=true
    0.upto(9) {|i|
      draw=draw && (full? (i))
    }
    return draw
  end

  def win?
    @board.each_index do |col|
      @board[col].each_index do |row|
        next if @board[col][row]==nil
        if row<=6
          return true if checkVertical(row,col)
        end
        if col<=6
          return true if checkHorizontal(row,col)
        end
        if row<=6 && col<=6
          return true if checkDiagRight(row,col)
        end
        if col>=3 && row<=6
          return true if checkDiagLeft(row,col)
        end
      end
    end    
    return false
  end

  def checkVertical(row,col)
    raise "Not implemented in this class"
  end

  def checkHorizontal(row,col)
    raise "Not implemented in this class"
  end

  def checkDiagRight(row,col)
    raise "Not implemented in this class"
  end

  def checkDiagLeft(row,col)
    raise "Not implemented in this class"
  end

end
