require 'gtk3'

class GameScreen

  def initialize
    @emptySlot=Gtk::Image.new("emptySlot.png")
    @blackPiece=Gtk::Image.new("blackPiece.png")
    @redPiece=Gtk::Image.new("redPiece.png")
    @oPiece=Gtk::Image.new("oPiece.png")
    @tPiece=Gtk::Image.new("tPiece.png")
    Gtk.init
    @builder=Gtk::Builder::new
    @builder.add_from_file("StartMenu.glade")
    @builder.connect_signals{|handler| method(handler)}
    window=@builder.get_object("window2")
    window.signal_connect("destroy"){Gtk.main_quit}
    window.show()
    Gtk.main()
  end

  def setup
    slots=[]
    1.upto(100) {|i| 
      slots << @builder.get_object("image"+i)
      slots[i].set_image(@emptySlot)
      event_box = Gtk::EventBox.new.add(buttons[i])
      event_box.signal_connect("button_press_event") {puts "Clicked #{i}"}
    }
    
    
    
  end

  def play(column)
    @builder.
  end

end
