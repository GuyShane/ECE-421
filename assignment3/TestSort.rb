require 'minitest/autorun'

class TestSort<Minitest::Test

  def test_file_sort
    
    #preconditions
    assert(File.exists?(input.txt))
    
    `./Sort.rb 50 input.txt`
    
    #postconditions
    
    
  end

end
