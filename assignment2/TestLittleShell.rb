require 'minitest/autorun'
require 'time'

=begin
This class runs tests for our LittleShell. It does this by
executing the shell and passing it commands. This runs
the shell for only the command passed to it, rather
than continually getting input from stdin.
=end

class TestLittleShell<Minitest::Test

  def test_pwd
    assert_equal(ENV["PWD"],`./LittleShell.rb pwd`.rstrip)
  end

  def test_mkdir
    #Preconditions
    assert(!(`./LittleShell.rb ls`.include? "newdir"))

    `./LittleShell.rb mkdir newdir`
    
    #Postconditions
    assert(`./LittleShell.rb ls`.include? "newdir")

    `./LittleShell.rb rmdir newdir`
  end

  def test_touch
    #Preconditions
    assert(!(`./LittleShell.rb ls`.include? "newfile.txt"))

    `./LittleShell.rb touch newfile.txt`

    #Postconditions
    assert(`./LittleShell.rb ls`.include? "newfile.txt")
    
    `./LittleShell.rb rm newfile.txt`
  end

  def test_mv
    #Preconditions
    assert(!(`./LittleShell.rb ls`.include? "newfile.txt"))
    assert(!(`./LittleShell.rb ls`.include? "another.txt"))    
    
    `./LittleShell.rb touch newfile.txt`
    `./LittleShell.rb mv newfile.txt another.txt`

    #Postconditions
    assert(`./LittleShell.rb ls`.include? "another.txt")
    assert(!(`./LittleShell.rb ls`.include? "newfile.txt"))
    
    `./LittleShell.rb rm another.txt`
  end

  def test_ls
    #Preconditions
    assert(!(`./LittleShell.rb ls`.include? "ls_test"))
    assert(!(`./LittleShell.rb ls`.include? "ls_test/file.txt"))

    `./LittleShell.rb mkdir ls_test`
    `./LittleShell.rb touch ls_test/file.txt`

    #Postconditions
    assert_equal("file.txt",`./LittleShell.rb ls ls_test/`.rstrip)

    `./LittleShell.rb rm ls_test/file.txt`
    `./LittleShell.rb rmdir ls_test`
  end

  def test_rm
    `./LittleShell.rb touch newfile.txt`
    #Preconditions
    assert(`./LittleShell.rb ls`.include? "newfile.txt")

    `./LittleShell.rb rm newfile.txt`

    #Postconditions
    assert(!(`./LittleShell.rb ls`.include? "newfile.txt"))
  end

  def test_rmdir
    `./LittleShell.rb mkdir newdir`
    #Preconditions
    assert(`./LittleShell.rb ls`.include? "newdir")

    `./LittleShell.rb rmdir newdir`

    #Postconditions
    assert(!(`./LittleShell.rb ls`.include? "newdir"))
  end

  def test_cat
    `./LittleShell.rb echo "testing cat" > cat_test.txt`
    #Preconditions
    assert(`./LittleShell.rb ls`.include? "cat_test.txt")
    
    file_text=`./LittleShell.rb cat cat_test.txt`.rstrip

    #Postconditions
    assert_equal("testing cat",file_text)

    `./LittleShell.rb rm cat_test.txt`
  end

  def test_echo
    assert_equal("hello",`./LittleShell.rb echo "hello"`.rstrip)
  end

  def test_output_redirect
    #Preconditions
    assert(!(`./LittleShell.rb ls`.include? "redirect_test.txt"))

    `./LittleShell.rb echo "testing redirection" > redirect_test.txt`

    #Postconditions
    assert(`./LittleShell.rb ls`.include? "redirect_test.txt")

    `./LittleShell.rb rm redirect_test.txt`    
  end

  def test_cp
    `./LittleShell.rb echo "testing copy" > cp_test.txt`
    #Preconditions
    assert(`./LittleShell.rb ls`.include? "cp_test.txt")
    assert(!(`./LittleShell.rb ls`.include? "cp_test2.txt"))    

    `./LittleShell.rb cp cp_test.txt cp_test2.txt`

    #Postconditions
    assert_equal(`./LittleShell.rb cat cp_test.txt`,
                 `./LittleShell.rb cat cp_test2.txt`)

    `./LittleShell.rb rm cp_test.txt`
    `./LittleShell.rb rm cp_test2.txt`
  end

  def test_cd
    `./LittleShell.rb mkdir cd_test`
    #Preconditions
    assert(`./LittleShell.rb ls`.include? "cd_test")

    current_dir=`./LittleShell.rb pwd`.rstrip
    `./LittleShell.rb cd ./cd_test`
    new_dir=`./LittleShell.rb pwd`.rstrip

    #Postconditions
    assert_equal(current_dir+"/cd_test",new_dir)

    `./LittleShell.rb cd ..`    
    `./LittleShell.rb rmdir cd_test`
  end

  def test_pipe
    #Preconditions
    assert(!(`./LittleShell.rb ls`.include? "hello.txt"))

    text=`./LittleShell.rb echo "hello" > hello.txt | cat`.rstrip

    #Postconditions
    assert_equal("hello",text)
  end

  def test_delay_print
    start=Time.now
    `./LittleShell.rb delay_print "Hello" 2000`
    finish=Time.now

    #Postconditions
    assert_equal(2,(finish-start).round)
  end

  def test_file_watch_creation
    #Preconditions
    assert(!(`./LittleShell.rb ls`.include? "new.txt"))

    a=`./LittleShell.rb FileWatchCreation "new.txt" 3000 {echo "hello"}`.rstrip
    start=Time.now
    `./LittleShell.rb touch new.txt`
    finish=Time.now

    #Postconditions
    assert_equal("hello",a)
    assert_equal(3,(finish-start).round)

    `./LittleShell.rb rm new.txt`        
  end

  def test_file_watch_alter
    `./LittleShell.rb touch new.txt`
    #Preconditions
    assert(`./LittleShell.rb ls`.include? "new.txt")

    a=`./LittleShell.rb FileWatchAlter "new.txt" 4000 {echo "hello"}`.rstrip
    start=Time.now
    `./LittleShell.rb touch new.txt`
    finish=Time.now

    #Postconditions
    assert_equal("hello",a)
    assert_equal(4,(finish-start).round)

    `./LittleShell.rb rm new.txt`    
  end

  def test_file_watch_destroy
    `./LittleShell.rb touch new.txt`
    #Preconditions
    assert(!(`./LittleShell.rb ls`.include? "new.txt"))

    a=`./LittleShell.rb FileWatchDestroy "new.txt" 5 {echo "hello"}`.rstrip
    start=Time.now
    `./LittleShell.rb rm new.txt`
    finish=Time.now

    #Postconditions
    assert_equal("hello",a)
    assert_equal(5,(finish-start).round)
  end

end
