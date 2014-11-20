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

  def win?
    @board.each_index do |row|
      @board[row].each_index do |col|
        next if @board[row][col]==:none
        if col<@board[row].size-3
          if @board[row][col]==@board[row][col+1] && @board[row][col+1]==@board[row][col+2] && @board[row][col+2]==@board[row][col+3]
            return @board[row][col]
          end
        end
        if row<@board.size-3
          if @board[row][col]==@board[row+1][col] && @board[row+1][col]==@board[row+2][col] && @board[row+2][col]==@board[row+3][col]
            return @board[row][col]
          end
        end

        if row<@board.size-3 && col<@board[row].size-3
          if @board[row][col]==@board[row+1][col+1] && @board[row+1][col+1]==@board[row+2][col+2] && @board[row+2][col+2]==@board[row+3][col+3]
            return @board[row][col]
          end
        end

        if row>3 && col<@board[row].size-3
          if @board[row][col]==@board[row-1][col+1] && @board[row-1][col+1]==@board[row-2][col+2] && @board[row-2][col+2]==@board[row-3][col+3]
            return @board[row][col]
          end
        end

      end
    end
    return nil    
  end
end
