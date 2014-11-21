require 'gtk2'
require './GameScreen'

class MenuScreen
  def initialize
    Gtk.init
    @builder=Gtk::Builder::new
    @builder.add_from_file("MenuScreen.glade")
    @builder.connect_signals{|handler| method(handler)}
    window=@builder.get_object("window1")
    button=@builder.get_object("button1")
    playerRadio=@builder.get_object("radiobutton1")
    modeRadio=@builder.get_object("radiobutton3")
    player=true
    mode=true
    playerRadio.signal_connect("clicked") {player=playerRadio.active?}
    modeRadio.signal_connect("clicked") {mode=modeRadio.active?}
    #player=@builder.get_object("radiobutton1").active?
    #mode=@builder.get_object("radiobutton3").active?
    button.signal_connect("clicked"){GameScreen.new(player,mode)}
    window.signal_connect("destroy"){Gtk.main_quit}
    window.show()
    Gtk.main()
  end
end
