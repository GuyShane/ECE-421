require './GameBoard'

class TraditionalBoard<GameBoard
  def checkVertical(row,col)
    return (@board[col][row]==@board[col][row+1]) &&
      (@board[col][row+1]==@board[col][row+2]) &&
      (@board[col][row+2]==@board[col][row+3])
  end

  def checkHorizontal(row,col)
    return (@board[col][row]==@board[col+1][row]) &&
      (@board[col+1][row]==@board[col+2][row]) &&
      (@board[col+2][row]==@board[col+3][row])
  end

  def checkDiagRight(row,col)
    return (@board[col][row]==@board[col+1][row+1]) &&
      (@board[col+1][row+1]==@board[col+2][row+2]) &&
      (@board[col+2][row+2]==@board[col+3][row+3])
  end

  def checkDiagLeft(row,col)
    return (@board[col][row]==@board[col-1][row+1]) &&
      (@board[col-1][row+1]==@board[col-2][row+2]) &&
      (@board[col-2][row+2]==@board[col-3][row+3])
  end

end
