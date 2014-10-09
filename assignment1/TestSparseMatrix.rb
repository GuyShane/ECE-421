require './SparseMatrix'
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

  def test_transpose
    test_matrix=SparseMatrix.new(7,4,{[1,1]=>6,[2,3]=>-5,[7,4]=>16})

    #Preconditions
    

    new=test_matrix.transpose()

    #Postconditions
    assert_equal(new.rows,test_matrix.cols)
    assert_equal(new.cols,test_matrix.rows)
  end

  def test_clear
    test_matrix=SparseMatrix.new(7,4,{[1,1]=>6,[2,3]=>-5,[7,4]=>16})

    #Preconditions
    assert(test_matrix.matrix!=nil)

    test_matrix=test_matrix.clear!

    #Postconditions
    assert_equal(test_matrix.count,0)
  end

  def test_count
    test_matrix=SparseMatrix.new(7,4,{[1,1]=>6,[2,3]=>-5,[7,4]=>16})

    #Preconditions
    assert(test_matrix.matrix!=nil)

    result=test_matrix.count

    #Postconditions
    assert(result!=nil)
    assert_equal(result,test_matrix.matrix.count)
  end

  def test_put
    test_matrix=SparseMatrix.new(5,6)
    to_put=5
    i=3
    j=4

    #Preconditions
    assert(i<=test_matrix.cols)
    assert(j<=test_matrix.rows)
    assert(i>=1)
    assert(j>=1)    
    assert(to_put.respond_to?:to_i)
    
    test_matrix[i,j]=to_put.to_i

    #Postconditions
    assert_equal(test_matrix[i,j],to_put)
  end

  def test_get
    test_matrix=SparseMatrix.new(7,4,{[1,1]=>6,[2,3]=>-5,[7,4]=>16})
    i=3
    j=2

    #Preconditions
    assert(i<=test_matrix.cols)
    assert(j<=test_matrix.rows)
    assert(i>=1)
    assert(j>=1)

    result=test_matrix[1,1]

    #Postconditions
    assert(result!=nil)
    assert_equal(result,6)
  end

  def test_negate
    test_matrix=SparseMatrix.new(7,4,{[1,1]=>6,[2,3]=>-5,[7,4]=>16})

    #Preconditions
    assert(test_matrix.matrix!=nil)

    test_matrix.negate!

    #Postconditions
    assert(test_matrix.matrix!=nil)
    assert_equal(test_matrix[1,1],-6)
    assert_equal(test_matrix[2,3],5)
  end

  def test_times_matrix
    a=SparseMatrix.new(7,4,{[1,1]=>6,[2,3]=>-5,[7,4]=>16})
    b=a.t

    #Preconditions
    assert_equal(a.cols,b.rows)

    result=a*b

    #Postconditions
    assert_equal(result.cols,b.cols)
    assert_equal(result.rows,a.rows)
  end

  def test_times_scalar
    test_matrix=SparseMatrix.new(7,4,{[1,1]=>6,[2,3]=>-5,[7,4]=>16})
    c=6

    #Preconditions
    assert(c.respond_to?:to_i)

    result=test_matrix*c.to_i

    #Postconditions
    assert_equal(result.cols,test_matrix.cols)
    assert_equal(result.rows,test_matrix.rows)
    assert_equal(result[1,1],test_matrix[1,1]*c)
  end

  def test_exp
    test_matrix=SparseMatrix.new(7,7,{[1,1]=>6,[2,3]=>-5,[7,4]=>16})
    k=3

    #Preconditions
    assert(test_matrix.square?)
    assert(k.respond_to?:to_i)
    
    result=test_matrix.exp(k)

    #Postconditions
    assert_equal(result.rows,test_matrix.rows)
    assert_equal(result.cols,test_matrix.cols)
  end

  def test_plus
    a=SparseMatrix.new(7,4,{[1,1]=>6,[2,3]=>-5,[7,4]=>16})
    b=SparseMatrix.new(7,4,{[1,1]=>-2,[2,3]=>15,[1,5]=>-1})

    #Preconditions
    assert_equal(a.cols,b.cols)
    assert_equal(a.rows,b.rows)

    result=a+b

    #Postconditions
    assert_equal(a.cols,b.cols)
    assert_equal(a.rows,b.rows)
    assert_equal(result[1,1],a[1,1]+b[1,1])
    assert_equal(result[1,5],b[1,5])
  end

  def test_minus
    a=SparseMatrix.new(7,4,{[1,1]=>6,[2,3]=>-5,[7,4]=>16})
    b=SparseMatrix.new(7,4,{[1,1]=>-2,[2,3]=>15,[1,5]=>-1})

    #Preconditions
    assert_equal(a.cols,b.cols)
    assert_equal(a.rows,b.rows)

    result=a-b

    #Postconditions
    assert_equal(a.cols,b.cols)
    assert_equal(a.rows,b.rows)
    assert_equal(result[1,1],a[1,1]-b[1,1])
    assert_equal(result[1,5],-b[1,5])
  end
  
  def test_determinant
    test_matrix=SparseMatrix.new(5,5,{[1,1]=>6,[2,3]=>-5,[5,4]=>16})

    #Preconditions
    assert_equal(self.rows,self.cols)

    result=test_matrix.determinant()

    #Postconditions
    assert(result.respond_to?:to_i)
  end

  def test_inverse
    test_matrix=SparseMatrix.new(5,5,{[1,1]=>6,[2,3]=>-5,[5,4]=>16})

    #Preconditions
    assert_equal(test_matrix.test_matrix,self.cols)
    assert_not_equal(test_matrix.det,0)

    new=test_matrix.inverse()

    #Postconditions
    assert_equal(test_matrix*new,SparseMatrix.identity(new.rows))
  end

  def test_cofactorMatrix
    test_matrix=SparseMatrix.new(5,5,{[1,1]=>6,[2,3]=>-5,[5,4]=>16})

    #Preconditions


    new=test_matrix.cofactorMatrix()

    #Postconditions
    assert_equal(test_matrix.rows,new.rows)
    assert_equal(test_matrix.cols,new.cols)
  end

  def test_cofactor
    test_matrix=SparseMatrix.new(5,5,{[1,1]=>6,[2,3]=>-5,[5,4]=>16})

    #Preconditions


    result=test_matrix.cofactor(1,1)

    #Postconditions
    assert(result.respond_to?:to_i)
  end

  def minor(ri,rf,ci,cf)
    test_matrix=SparseMatrix.new(5,5,{[1,1]=>6,[2,3]=>-5,[5,4]=>16})
    ri=2
    rf=4
    ci=2
    cf=5

    #Preconditions
    assert(ri<test_matrix.rows)
    assert(rf<=test_matrix.rows)
    assert(ci<test_matrix.cols)
    assert(ci<=test_matrix.cols)

    new=test_matrix.minor

    #Postconditions
    assert(test_matrix.rows>=new.rows)
    assert(test_matrix.cols>=new.cols)
  end

  def test_real
    test_matrix=SparseMatrix.new(7,5,{[1,1]=>6,[2,3]=>-5,[5,4]=>16})

    #Preconditions
    assert(test_matrix.matrix!=nil)

    result=test_matrix.real?

    #Postconditions
    assert(result.is_a?(TrueClass)||result.is_a?(FalseClass))
    assert(result)
  end

  def test_regular
    test_matrix=SparseMatrix.new(5,5,{[1,1]=>6,[2,3]=>-5,[5,4]=>16})

    #Preconditions
    assert(test_matrix.matrix!=nil)

    result=test_matrix.regular?

    #Postconditions
    assert(result.is_a?(TrueClass)||result.is_a?(FalseClass))
  end

  def test_round
    test_matrix=SparseMatrix.new(5,5,{[1,1]=>6,[2,3]=>-5,[5,4]=>16})

    #Preconditions
    assert(test_matrix.matrix!=nil)

    new=test_matrix.round

    #Postconditions
    assert(new.rows==test_matrix.rows)
    assert(new.cols==test_matrix.cols)
  end

  def test_singular
    test_matrix=SparseMatrix.new(5,5,{[1,1]=>6,[2,3]=>-5,[5,4]=>16})

    #Preconditions
    assert(test_matrix.matrix!=nil)
    
    result=test_matrix.singular?

    #Postconditions
    assert(result.is_a?(TrueClass)||result.is_a?(FalseClass))
  end

  def test_trace
    test_matrix=SparseMatrix.new(5,5,{[1,1]=>6,[2,3]=>-5,[5,4]=>16})

    #Preconditions
    assert(test_matrix.matrix!=nil)
    assert(test_matrix.square?)

    result=test_matrix.trace

    #Postconditions
    assert(result.respond_to?:to_i)
    assert(result==6)
  end

  def test_square
    test_matrix=SparseMatrix.new(5,5,{[1,1]=>6,[2,3]=>-5,[5,4]=>16})

    #Preconditions
    assert(test_matrix.matrix!=nil)

    result=test_matrix.square?

    #Postconditions
    assert(result.is_a?(TrueClass)||result.is_a?(FalseClass))    
  end

  def test_symmetric
    test_matrix=SparseMatrix.new(5,5,{[1,1]=>6,[2,3]=>-5,[5,4]=>16})

    #Preconditions
    assert(test_matrix.matrix!=nil)
    assert(test_matrix.square?)

    result=test_matrix.symmetric?

    #Postconditions
    assert(result.is_a?(TrueClass)||result.is_a?(FalseClass))    
  end

  def test_zero
    test_matrix=SparseMatrix.new(5,5,{[1,1]=>6,[2,3]=>-5,[5,4]=>16})

    #Preconditions
    assert(test_matrix.matrix!=nil)

    result=test_matrix.zero?

    #Postconditions
    assert(result.is_a?(TrueClass)||result.is_a?(FalseClass))
  end

  def test_identity
    size=5

    #Preconditions
    assert(size.respond_to?:to_i)

    test_matrix=SparseMatrix.identity(size)

    #Postconditions
    assert(test_matrix.square?)
    assert(test_matrix.cols=size)
    assert_equal(test_matrix.trace,size)
  end

end
