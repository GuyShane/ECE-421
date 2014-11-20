require 'gtk2'
require './GameBoard'

class GameScreen

  def initialize(*args)
    @player=args[0] ? 1 : 2
    @mode=args[1] ? 1 : 2
    @turn=1
    @board=GameBoard.new
    @emptySlot=Gdk::Pixbuf.new("emptySlot.png")
    @blackPiece=Gdk::Pixbuf.new("blackPiece.png")
    @redPiece=Gdk::Pixbuf.new("redPiece.png")
    @oPiece=Gdk::Pixbuf.new("oPiece.png")
    @tPiece=Gdk::Pixbuf.new("tPiece.png")
    @norms=[@redPiece,@blackPiece]
    @toots=[@tPiece,@oPiece]
    Gtk.init
    @builder=Gtk::Builder::new
    @builder.add_from_file("GameScreen.glade")
    @builder.connect_signals{|handler| method(handler)}
    window=@builder.get_object("window1")
    window.signal_connect("destroy"){Gtk.main_quit}
    setup
    window.show_all()
    Gtk.main()
  end

  def setup
    1.upto(100) {|i| 
      @builder.get_object("image"+i.to_s).set_pixbuf(@emptySlot)
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
      @builder.get_object("image"+piece.to_s).set_pixbuf(@norms[@turn-1])
      @turn=@turn==1 ? 2 : 1
      @builder.get_object("label1").set_label("Whose turn: Player "+@turn.to_s)
    end
  end

end
