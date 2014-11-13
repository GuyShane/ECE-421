require 'gtk2'
window=Gtk::Window.new
button=Gtk::Button.new("butt")
button.signal_connect("clicked") {puts "button"}
window.signal_connect("destroy") {Gtk.main_quit}
window.border_width=200
window.add(button)
window.show_all
Gtk.main
