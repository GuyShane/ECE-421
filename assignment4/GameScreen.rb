require 'gtk2'
require './TraditionalBoard'
require './TootBoard'
require './GamePiece'
require './ComputerPlayer'

class GameScreen

  def initialize(*args)
    @player=args[0] ? 1 : 2
    @mode=args[1] ? 1 : 2
    @turn=1
    @board=@mode==1 ? TraditionalBoard.new : TootBoard.new
    @pieces=GamePiece.new(@mode)
    @comp=ComputerPlayer.new(@board)
    Gtk.init
    @builder=Gtk::Builder::new
    @builder.add_from_file("GameScreen.glade")
    #@builder.connect_signals{|handler| method(handler)}
    window=@builder.get_object("window1")
    window.signal_connect("destroy"){Gtk.main_quit}
    setup
    window.show_all()
    Gtk.main()
  end

  def setup
    1.upto(100) {|i| 
      @builder.get_object("image"+i.to_s).set_pixbuf(@pieces.emptySlot)
    }
    1.upto(10) {|i|
      @builder.get_object("button"+i.to_s).signal_connect("clicked"){play(i-1)}
    }
  end

  def play(column)
    if !@board.full? column
      height=@board.height(column)
      @board.board[column] << @turn
      piece=(100-(10*(height+1)))+(column==0? 10 : column) 
      @builder.get_object("image"+piece.to_s).set_pixbuf(@pieces.pics[@turn-1])
      if @board.win?
        wonYay
      elsif @board.draw?
        drawBoo
      else
        advanceTurn
        if @player==1 && @turn==2
          compCol=@comp.getMove
          height=@board.height(compCol)
          @board.board[compCol] << @turn
          piece=(100-(10*(height+1)))+(compCol==0? 10 : compCol) 
          @builder.get_object("image"+piece.to_s).set_pixbuf(@pieces.pics[@turn-1])          
          if @board.win?
            wonYay
          elsif @board.draw?
            drawBoo
          else
            advanceTurn
          end
        end
      end
    end
  end

  def wonYay
    1.upto(10) {|i|
      @builder.get_object("button"+i.to_s).destroy
    }
    @builder.get_object("label1").set_label("Player "+@turn.to_s+" Totally won!")            
  end

  def drawBoo
    1.upto(10) {|i|
      @builder.get_object("button"+i.to_s).destroy
    }
    @builder.get_object("label1").set_label("A draw. Lame")               
  end

  def advanceTurn
    @turn=@turn==1 ? 2 : 1
    @builder.get_object("label1").set_label("Whose turn: Player "+@turn.to_s)
  end

end
