require 'gtk3'
require './GameScreen'

class MenuScreen
  def initialize
    Gtk.init
    @builder=Gtk::Builder::new
    @builder.add_from_file("StartMenu.glade")
    @builder.connect_signals{|handler| method(handler)}
    window=@builder.get_object("window1")
    button=@builder.get_object("button1")
    button.signal_connect("clicked"){window=@builder.get_object("window2")}
    window.signal_connect("destroy"){Gtk.main_quit}
    window.show()
    Gtk.main()
  end
end
