require 'gtk2'

class TTTGlade
 

  X = "X"
  O = "O"

  def initialize
    if __FILE__ == $0
      Gtk.init

      @builder = Gtk::Builder::new
      @builder.add_from_file("MenuScreen.glade")
      @builder.connect_signals{ |handler| method(handler) }  # (No handlers yet, but I will have eventually)
      @blankTile = "XOXOX"
      window = @builder.get_object("window1")
      window.signal_connect( "destroy" ) { Gtk.main_quit }
      window.show()
      Gtk.main()
    end
  end


  def setUpTheBoard

      1.upto(9) { |i|
         @builder.get_object("button" + i.to_s).set_label(@blankTile);
      }
      @x = 0
      @o = 1
      @turn = @x
  end


#
# Step 4: set up a method to handle a tile being flipped
#   
#
  def button_clicked(tileNumber)
   #
   #
   # Step 6: set up some simple logic to flip the tiles according
   #   to whose turn it is
   #   
   #
    tmp = @builder.get_object("button" + tileNumber.to_s).label
    if tmp == @blankTile
       if @turn == @x
          @turn = @o
          @builder.get_object("button" + tileNumber.to_s).set_label(X) 
       else
          @turn = @x
          @builder.get_object("button" + tileNumber.to_s).set_label(O) 
       end
    end

    if win?
      system("clear")
      puts "YOU ARE A WINNER" ## exercise: design a pop up winner window
    end
  end  


#
# Step 8: Write a method to determine if we have a winning board. We'll do it the
#         "brute force" way for illestration purposes
#
#        Exercise: What is a more elegant way to do this? (Hint: magic square)
#   
#
  def win?

     return threes(1,2,3) ||
            threes(4,5,6) ||
            threes(7,8,9) ||
            threes(1,4,7) ||
            threes(2,5,8) ||
            threes(3,6,9) ||
            threes(1,5,9) ||
            threes(7,5,3)
  end


#
# Step 7: Write a method to determine if any 3 given tiles are a winning combination
#
#   
#
  def threes(a,b,c)

    t1 = @builder.get_object("button" + a.to_s).label
    t2 = @builder.get_object("button" + b.to_s).label
    t3 = @builder.get_object("button" + c.to_s).label
    return (t1 != @blankTile && t2 != @blankTile && t3 != @blankTile) && (t1 == t2 && t2 == t3)

  end


  def gtk_main_quit
    puts "Say goodnight Gracie!"
    Gtk.main_quit()
  end


end


hello = TTTGlade.new
