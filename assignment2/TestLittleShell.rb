require 'minitest/autorun'
require 'time'

class TestLittleShell<Minitest::Test
  #`./LittleShell.rb ls`
  def test_pwd
    assert_equal(ENV["PWD"],`./LittleShell.rb pwd`.rstrip)
  end

  def test_mkdir
    `./LittleShell.rb mkdir newdir`
    assert(`./LittleShell.rb ls`.include? "newdir")
    `./LittleShell.rb rmdir newdir`
  end

  def test_touch
    `./LittleShell.rb touch newfile.txt`
    assert(`./LittleShell.rb ls`.include? "newfile.txt")
    `./LittleShell.rb rm newfile.txt`
  end

  def test_mv
    `./LittleShell.rb touch newfile.txt`
    `./LittleShell.rb mv newfile.txt another.txt`
    assert(`./LittleShell.rb ls`.include? "another.txt")
    assert(!(`./LittleShell.rb ls`.include? "newfile.txt"))
    `./LittleShell.rb rm another.txt`
  end

  def test_ls
    `./LittleShell.rb mkdir ls_test`
    `./LittleShell.rb touch ls_test/file.txt`
    assert_equal(`./LittleShell.rb ls ls_test/`.rstrip,"file.txt")
    `./LittleShell.rb rm ls_test/file.txt`
    `./LittleShell.rb rmdir ls_test`
  end

  def test_rm
    `./LittleShell.rb touch newfile.txt`
    `./LittleShell.rb rm newfile.txt`
    assert(!(`./LittleShell.rb ls`.include? "newfile.txt"))
  end

  def test_rmdir
    `./LittleShell.rb mkdir newdir`
    `./LittleShell.rb rmdir newdir`
    assert(!(`./LittleShell.rb ls`.include? "newdir"))
  end

  def test_cat
    `./LittleShell.rb echo "testing cat" > cat_test.txt`
    assert_equal(`./LittleShell.rb cat cat_test.txt`.rstrip,"testing cat")
    `./LittleShell.rb rm cat_test.txt`
  end

  def test_echo
    assert_equal(`./LittleShell.rb echo "hello"`.rstrip,"hello")
  end

  def test_cp
    `./LittleShell.rb echo "testing copy" > cp_test.txt`
    `./LittleShell.rb cp cp_test.txt cp_test2.txt`
    assert_equal(`./LittleShell.rb cat cp_test.txt`,
                 `./LittleShell.rb cat cp_test2.txt`)
    `./LittleShell.rb rm cp_test.txt`
    `./LittleShell.rb rm cp_test2.txt`
  end

  def test_cd
    `./LittleShell.rb mkdir cd_test`
    current_dir=`./LittleShell.rb pwd`.rstrip
    `./LittleShell.rb cd /cd_test`
    new_dir=`./LittleShell.rb pwd`.rstrip
    assert_equal(current_dir+"/cd_test",new_dir)
  end

  def test_delay_print
    start=Time.now
    `./LittleShell.rb delay_print(2,"hello")`
    finish=Time.now
    assert_equal(2,(finish-start).round)
  end

  def test_file_watch_creation
    a=0
    `./LittleShell.rb FileWatchCreation(3,"new.txt") {a=1}`
    start=Time.now
    `./LittleShell.rb touch new.txt`
    finish=Time.now
    assert_equal(1,a)
    assert_equal(3,(finish-start).round)
  end

  def test_file_watch_alter
    a=0
    `./LittleShell.rb touch new.txt`
    `./LittleShell.rb FileWatchAlter(4,"new.txt") {a=1}`
    start=Time.now
    `./LittleShell.rb touch new.txt`
    finish=Time.now
    assert_equal(1,a)
    assert_equal(4,(finish-start).round)
  end

  def test_file_watch_destroy
    a=0
    `./LittleShell.rb touch new.txt`
    `./LittleShell.rb FileWatchDestroy(5,"new.txt") {a=1}`
    start=Time.now
    `./LittleShell.rb rm new.txt`
    finish=Time.now
    assert_equal(1,a)
    assert_equal(5,(finish-start).round)
  end

end
