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
    assert_equal(ENV["PWD"],`./LittleShell pwd`.rstrip)
  end

  def test_mkdir
    #Preconditions
    assert(!(`./LittleShell ls`.include? "newdir"))

    `./LittleShell mkdir newdir`
    
    #Postconditions
    assert(`./LittleShell ls`.include? "newdir")

    `./LittleShell rmdir newdir`
  end

  def test_touch
    #Preconditions
    assert(!(`./LittleShell ls`.include? "newfile.txt"))

    `./LittleShell touch newfile.txt`

    #Postconditions
    assert(`./LittleShell ls`.include? "newfile.txt")
    
    `./LittleShell rm newfile.txt`
  end

  def test_mv
    #Preconditions
    assert(!(`./LittleShell ls`.include? "newfile.txt"))
    assert(!(`./LittleShell ls`.include? "another.txt"))    
    
    `./LittleShell touch newfile.txt`
    `./LittleShell mv newfile.txt another.txt`

    #Postconditions
    assert(`./LittleShell ls`.include? "another.txt")
    assert(!(`./LittleShell ls`.include? "newfile.txt"))
    
    `./LittleShell rm another.txt`
  end

  def test_ls
    #Preconditions
    assert(!(`./LittleShell ls`.include? "ls_test"))
    assert(!(`./LittleShell ls`.include? "ls_test/file.txt"))

    `./LittleShell mkdir ls_test`
    `./LittleShell touch ls_test/file.txt`

    #Postconditions
    assert_equal("file.txt",`./LittleShell ls ls_test/`.rstrip)

    `./LittleShell rm ls_test/file.txt`
    `./LittleShell rmdir ls_test`
  end

  def test_rm
    `./LittleShell touch newfile.txt`
    #Preconditions
    assert(`./LittleShell ls`.include? "newfile.txt")

    `./LittleShell rm newfile.txt`

    #Postconditions
    assert(!(`./LittleShell ls`.include? "newfile.txt"))
  end

  def test_rmdir
    `./LittleShell mkdir newdir`
    #Preconditions
    assert(`./LittleShell ls`.include? "newdir")

    `./LittleShell rmdir newdir`

    #Postconditions
    assert(!(`./LittleShell ls`.include? "newdir"))
  end

  def test_cat
    `./LittleShell echo "testing cat" > cat_test.txt`
    #Preconditions
    assert(`./LittleShell ls`.include? "cat_test.txt")
    
    file_text=`./LittleShell cat cat_test.txt`.rstrip

    #Postconditions
    assert_equal("testing cat",file_text)

    `./LittleShell rm cat_test.txt`
  end

  def test_echo
    assert_equal("hello",`./LittleShell echo "hello"`.rstrip)
  end

  def test_output_redirect
    #Preconditions
    assert(!(`./LittleShell ls`.include? "redirect_test.txt"))

    `./LittleShell echo "testing redirection" > redirect_test.txt`

    #Postconditions
    assert(`./LittleShell ls`.include? "redirect_test.txt")

    `./LittleShell rm redirect_test.txt`    
  end

  def test_cp
    `./LittleShell echo "testing copy" > cp_test.txt`
    #Preconditions
    assert(`./LittleShell ls`.include? "cp_test.txt")
    assert(!(`./LittleShell ls`.include? "cp_test2.txt"))    

    `./LittleShell cp cp_test.txt cp_test2.txt`

    #Postconditions
    assert_equal(`./LittleShell cat cp_test.txt`,
                 `./LittleShell cat cp_test2.txt`)

    `./LittleShell rm cp_test.txt`
    `./LittleShell rm cp_test2.txt`
  end

  def test_cd
    `./LittleShell mkdir cd_test`
    #Preconditions
    assert(`./LittleShell ls`.include? "cd_test")

    current_dir=`./LittleShell pwd`.rstrip
    `./LittleShell cd ./cd_test`
    new_dir=`./LittleShell pwd`.rstrip

    #Postconditions
    assert_equal(current_dir+"/cd_test",new_dir)

    `./LittleShell cd ..`    
    `./LittleShell rmdir cd_test`
  end

  def test_pipe
    #Preconditions
    assert(!(`./LittleShell ls`.include? "hello.txt"))

    text=`./LittleShell echo "hello" > hello.txt | cat`.rstrip

    #Postconditions
    assert_equal("hello",text)
  end

  def test_delay_print
    start=Time.now
    `./LittleShell delay_print "Hello" 2000`
    finish=Time.now

    #Postconditions
    assert_equal(2,(finish-start).round)
  end

  def test_file_watch_creation
    #Preconditions
    assert(!(`./LittleShell ls`.include? "new.txt"))

    a=`./LittleShell FileWatchCreation "new.txt" 3000 {echo "hello"}`.rstrip
    start=Time.now
    `./LittleShell touch new.txt`
    finish=Time.now

    #Postconditions
    assert_equal("hello",a)
    assert_equal(3,(finish-start).round)

    `./LittleShell rm new.txt`        
  end

  def test_file_watch_alter
    `./LittleShell touch new.txt`
    #Preconditions
    assert(`./LittleShell ls`.include? "new.txt")

    a=`./LittleShell FileWatchAlter "new.txt" 4000 {echo "hello"}`.rstrip
    start=Time.now
    `./LittleShell touch new.txt`
    finish=Time.now

    #Postconditions
    assert_equal("hello",a)
    assert_equal(4,(finish-start).round)

    `./LittleShell rm new.txt`    
  end

  def test_file_watch_destroy
    `./LittleShell touch new.txt`
    #Preconditions
    assert(!(`./LittleShell ls`.include? "new.txt"))

    a=`./LittleShell FileWatchDestroy "new.txt" 5 {echo "hello"}`.rstrip
    start=Time.now
    `./LittleShell rm new.txt`
    finish=Time.now

    #Postconditions
    assert_equal("hello",a)
    assert_equal(5,(finish-start).round)
  end

end
