require './Player'

class ComputerPlayer<Player
  def getMove
    #return rand(10)
    moves=[]
    0.upto(9) {|i|
      moves << getMoveScore(i)
    }
    return moves.index(moves.max)
  end
  
  def getMoveScore(column)
    score=0
    row=@board.height(column)
    (1...3).each do |i|
      begin
        if @board.board[column-i][row].to_i==1
          score+=1
        else
          break
        end
      rescue
        break
      end
    end
    (1...3).each do |i|
      begin
        if @board.board[column+i][row].to_i==1
          score+=1
        else
          break
        end
      rescue
        break
      end
    end
    (1...3).each do |i|
      begin
        if @board.board[column][row-i].to_i==1
          score+=1
        else
          break
        end
      rescue
        break
      end
    end
    (1...3).each do |i|
      begin
        if @board.board[column-i][row-i].to_i==1
          score+=1
        else
          break
        end
      rescue
        break
      end
    end
    (1...3).each do |i|
      begin
        if @board.board[column+i][row-i].to_i==1
          score+=1
        else
          break
        end
      rescue
        break
      end
    end
    return score
  end
end
