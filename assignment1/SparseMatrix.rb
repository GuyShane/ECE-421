require 'test-unit'

class SparseMatrix

  attr_reader :rows, :cols, :matrix

  def initialize(matrix)
    #Preconditions
    assert(matrix.cols>0)
    assert(matrix.rows>0)
    assert(matrix.is_a?SparseMatrix)

    #Postconditions
    assert_equal(self.rows,matrix.rows)
    assert_equal(self.cols,matrix.cols)
  end

  def initialize(cols,rows)
    #Preconditions
    assert(cols>0)
    assert(rows>0)

    #Postconditions
    assert_equal(self.cols,cols)
    assert_equal(self.rows,rows)
  end

  def initialize(cols,rows,dok)
    #Preconditions
    assert(cols>0)
    assert(rows>0)
    assert(dok.is_a?Hash)

    #Postconditions
    assert_equal(self.cols,cols)
    assert_equal(self.rows,rows)
    assert_equal(self.matrix,dok)
  end

  def transpose()
    #Preconditions
    assert_equal(self.rows,self.cols)

    #Postconditions
    assert_equal(result.rows,self.rows)
    assert_equal(result.cols,self.cols)
  end

  def determinant()
    #Preconditions
    assert_equal(self.rows,self.cols)

    #Postconditions
    assert(result.respond_to?:to_i)
  end

  def inverse()
    #Preconditions
    assert_equal(self.rows,self.cols)
    assert_not_equal(a.det,0)

    #Postconditions
    assert_equal(self*result,SparseMatrix.identity)
  end

  def minor(ri,rf,ci,cf)
    #Preconditions
    assert(ri<self.rows)
    assert(rf<=self.rows)
    assert(ci<self.cols)
    assert(ci<=self.cols)

    #Postconditions
    assert(self.rows>=result.rows)
    assert(self.cols>=result.cols)
  end

  def real?()
    #Preconditions
    assert(self.matrix!=nil)

    #Postconditions
    assert(result.is_a?(TrueClass)||result.is_a?(FalseClass))
  end

  def regular?()
    #Preconditions
    assert(self.matrix!=nil)

    #Postconditions
    assert(result.is_a?(TrueClass)||result.is_a?(FalseClass))
  end

  def round(digits=0)
    #Preconditions
    assert(self.matrix!=nil)

    #Postconditions
    assert(result.rows==self.rows)
    assert(result.cols==self.cols)
  end

  def singular?()
    #Preconditions
    assert(self.matrix!=nil)

    #Postconditions
    assert(result.is_a?(TrueClass)||result.is_a?(FalseClass))
  end

  def trace()
    #Preconditions
    assert(self.matrix!=nil)

    #Postconditions
    assert(k.respond_to?:to_i)
  end

  def square?()
    #Preconditions
    assert(self.matrix!=nil)

    #Postconditions
    assert(result.is_a?(TrueClass)||result.is_a?(FalseClass))    
  end

  def symmetric?()
    #Preconditions
    assert(self.matrix!=nil)
    assert(self.square?)

    #Postconditions
    assert(result.is_a?(TrueClass)||result.is_a?(FalseClass))    
  end

  def zero?()
    #Preconditions
    assert(self.matrix!=nil)

    #Postconditions
    assert(result.is_a?(TrueClass)||result.is_a?(FalseClass))
  end

  def identity(size)
    #Preconditions
    assert(size.respond_to?:to_i)

    #Postconditions
    assert(result.rows==result.cols==size)
    assert_equal(self.trace,k)
  end

  def plus(m)
    #Preconditions
    assert_equal(self.cols,m.cols)
    assert_equal(self,rows,m.rows)

    #Postconditions
    assert(result.rows==self.rows)
    assert(result.cols==self.cols)
  end

  def minus(m)
    #Preconditions
    assert_equal(self.cols,m.cols)
    assert_equal(self,rows,m.rows)
    
    #Postconditions
    assert(result.rows==self.rows)
    assert(result.cols==self.cols)
  end

  def times(m)
    #Preconditions
    assert(m.respond_to?:*)

    #Postconditions
    assert_equal(result.cols,self.cols)
  end

  def exp(k)
    #Preconditions
    assert(self.square?)
    assert(k.respond_to?:to_i)

    #Postconditions
    assert_equal(result.rows,self.rows)
    assert_equal(result.cols,self.cols)
  end

  def negate!()
    #Preconditions
    assert(self.matrix!=nil)

    #Postconditions
    assert(self.matrix!=nil)
  end

  def get(i,j)
    #Preconditions
    assert(i<=self.cols)
    assert(j<=self.rows)

    #Postconditions
    assert(result!=nil)
  end

  def put(i,j,v)
    #Preconditions
    assert(i<=self.cols)
    assert(j<=self.rows)
    assert(v.respond_to?:to_i)

    #Postconditions
    assert_equal(self[i,j],v)
  end

  def count()
    #Preconditions
    assert(self.matrix!=nil)

    #Postconditions
    assert(result!=nil)
  end

  def clear()
    #Preconditions
    assert(self.matrix!=nil)

    #Postconditions
    assert_equal(self.count,0)
  end

end