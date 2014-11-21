class GamePiece
  attr_reader :pics,:emptySlot
  def initialize(mode)
    @emptySlot=Gdk::Pixbuf.new("emptySlot.png")
    @blackPiece=Gdk::Pixbuf.new("blackPiece.png")
    @redPiece=Gdk::Pixbuf.new("redPiece.png")
    @oPiece=Gdk::Pixbuf.new("oPiece.png")
    @tPiece=Gdk::Pixbuf.new("tPiece.png")
    @norms=[@redPiece,@blackPiece]
    @toots=[@tPiece,@oPiece]
    @pieceSets=[@norms,@toots]
    @pics=@pieceSets[mode-1]
  end
end
