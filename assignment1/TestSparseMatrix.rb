require './implementations.rb'
require 'minitest/autorun'

class TestSparseMatrix<Minitest::Test

  def test_initialize_matrix
    test_matrix=SparseMatrix.new(7,4,{[1,1]=>6,[2,3]=>-5,[7,4]=>16})
    #Preconditions
    assert(test_matrix.cols>0)
    assert(test_matrix.rows>0)
    assert(test_matrix.is_a?SparseMatrix)

    other=SparseMatrix.new(test_matrix)

    #Postconditions
    assert_equal(other.rows,test_matrix.rows)
    assert_equal(other.cols,test_matrix.cols)
  end

  def test_initialize_dimens
    cols=7
    rows=12
    #Preconditions
    assert(cols>0)
    assert(rows>0)

    other=SparseMatrix.new(cols,rows)

    #Postconditions
    assert_equal(other.cols,cols)
    assert_equal(other.rows,rows)
  end

  def test_intialize_dok
    cols=3
    rows=10
    dok={[1,1]=>5,[3,6]=>-10,[2,8]=>63}
    #Preconditions
    assert(cols>0)
    assert(rows>0)
    assert(dok.is_a?Hash)

    other=SparseMatrix.new(cols,rows,dok)

    #Postconditions
    assert_equal(other.cols,cols)
    assert_equal(other.rows,rows)
    assert_equal(other.matrix,dok)
  end

  def test_transpose()
    test_matrix=SparseMatrix.new(7,4,{[1,1]=>6,[2,3]=>-5,[7,4]=>16})

    #Preconditions
    

    new=test_matrix.transpose()

    #Postconditions
    assert_equal(new.rows,test_matrix.cols)
    assert_equal(new.cols,test_matrix.rows)
  end



end
