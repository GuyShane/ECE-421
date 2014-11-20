require 'gtk3'

class MenuScreen
  def initialize
    if __FILE__==$0
      Gtk.init
      @builder=Gtk::Builder::new
      @builder.add_from_file("StartMenu.glade")
      @builder.connect_signals{|handler| method(handler)}
      window=@builder.get_object("window1")
      window.signal_connect("destroy"){Gtk.main_quit}
      window.show()
      Gtk.main()
    end
  end
end

s=MenuScreen.new
