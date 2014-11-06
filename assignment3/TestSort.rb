gem "minitest"
require 'minitest/autorun'

require './Sorter'

class TestSort<Minitest::Test

  def test_file_sort
    
    #preconditions
    assert(File.exists? "input.txt")
    assert(!(File.exists? "output.txt"))

    Sorter.sort(10000,input.txt)
    
    #postconditions
    assert(File.exists? "input.txt")
    assert(File.exists? "output.txt")
    assert(SortTest.sorted? "output.txt")

  end

  def test_input_sort 

    #Preconditions
    assert(!(File.exists? "output.txt"))
    
    myArray=[]
    (0..10000).each {myArray << rand(10000000)}
    Sorter.sort(10000,myArray)

    #Postconditions
    assert(File.exists? "output.txt")
    assert(SortTest.sorted? "output.txt")
    
  end

  def test_timeout

    #Preconditions
    assert(!(File.exists? "output.txt"))
    
    myArray=[]
    (0..10000).each {myArray << rand(10000000)}
    Sorter.sort(0,myArray)

    #Postconditions
    assert(!(File.exists? "output.txt"))

  end

  def test_custom_comparator
    
    #Preconditions
    assert(!(File.exists? "output.txt"))

    myArray=[]
    (0..10000).each {myArray << rand(10000000)}
    Sorter.sort(1000,myArray) {|a,b| b<=>a}

    #Postconditions
    assert(File.exists? "output.txt")
    assert(Sorter.sorted?(output.txt){|a,b| b<=>a})

  end

  def test_compare_string

    #Preconditions
    assert(!(File.exists? "output.txt"))

    myArray=[]
    (0..10000).each {myArray << rand(10000000).to_s}
    Sorter.sort(10000,myArray)

    #Postconditions
    assert(File.exists? "output.txt")
    assert(Sorter.sorted?(output.txt))

  end

  def test_thread_error

    #Preconditions
    assert(!(File.exists? "output.txt"))

    myArray=[]
    (0..10000).each {myArray << rand(10000000)}
    myArray[6000]=nil
    Sorter.sort(10000,myArray)

    #Postconditions
    assert(!(File.exists? "output.txt"))

  end

end
