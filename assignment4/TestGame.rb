gem "minitest"
require 'minitest/autorun'

require './Game'

class TestGame<Minitest::Test
  
  def test_winP1_four_mode
    game=Game.init("live","four")
    player1=game::P1
    player2=game::P2

    game.play(player1,0)
    game.play(player2,1)

    game.play(player1,0)
    game.play(player2,1)

    game.play(player1,0)
    game.play(player2,1)

    #Preconditions
    assert(player1.can_win)
    assert_equal(1,game.turn)

    game.play(player1,0)

    #Postconditions
    assert(game.won)
    assert_equal(1,game.winner)
  end

  def test_winP2_four_mode
    game=Game.init("live","four")
    player1=game::P1
    player2=game::P2

    game.play(player1,0)
    game.play(player2,1)

    game.play(player1,0)
    game.play(player2,1)

    game.play(player1,0)
    game.play(player2,1)

    game.play(player1,2)

    #Preconditions
    assert(player2.can_win)
    assert_equal(2,game.turn)

    game.play(player2,1)

    #Postconditions
    assert(game.won)
    assert_equal(2,game.winner)
  end

  def test_winP1_toot_mode
    game=Game.init("live","toot")
    player1=game::P1
    player2=game::P2

    game.play(player1,0)
    game.play(player2,0)

    game.play(player1,1)
    game.play(player2,0)

    #Preconditions
    assert(player1.can_win)
    assert_equal(1,game.turn)

    game.play(player1,0)

    #Postconditions
    assert(game.won)
    assert_equal(1,game.winner)
  end

  def test_winP2_toot_mode
    game=Game.init("live","toot")
    player1=game::P1
    player2=game::P2

    game.play(player1,1)
    game.play(player2,0)
    game.play(player1,2)

    #Preconditions
    assert(player2.can_win)
    assert_equal(2,game.turn)

    game.play(player2,3)

    #Postconditions
    assert(game.won)
    assert_equal(1,game.winner)
  end


  def test_full
    game=Game.init("live","four")
    player1=game::P1
    player2=game::P2

    game.play(player1,0)
    game.play(player2,0)
    game.play(player1,0)
    game.play(player2,0)
    game.play(player1,0)
    game.play(player2,0)
    game.play(player1,0)
    game.play(player2,0)
    game.play(player1,0)
    game.play(player2,0)

    #Preconditions
    assert_equal(10,game.height(0))
    assert_equal(1,game.turn)

    game.play(player1,0)

    #Postconditions
    assert_equal(10,game.height(0))
    assert_equal(1,game.turn)
  end

  def test_turns
    game=Game.init("live","four")
    player1=game::P1
    player2=game::P2
    
    #Preconditions
    assert_equal(1,game.turn)

    game.play(player1,0)

    #Postconditions
    assert_equal(2,game.turn)
  end

  def test_computer
    game=Game.init("computer","four")
    player1=game::P1
    computer=game::P2

    #Preconditions
    assert_equal(0,game.num_pieces)
    assert_equal(1,game.turn)

    game.play(player1,0)

    #Postconditions
    assert_equal(1,game.turn)
    assert_equal(2,game.num_pieces)
  end

end
