require 'test-unit'

class SparseMatrix

  attr_reader :rows, :cols, :matrix

  def initialize(matrix)
    #Preconditions
    assert(matrix.cols>0)
    assert(matrix.rows>0)
    assert(matrix.is_a?SparseMatrix)

    @rows=matrix.rows
    @cols=matrix.cols
    @matrix=matrix.matrix.dup

    #Postconditions
    assert_equal(self.rows,matrix.rows)
    assert_equal(self.cols,matrix.cols)
  end

  def initialize(cols,rows)
    #Preconditions
    assert(cols>0)
    assert(rows>0)
    
    @cols,@rows=cols,rows
    @matrix={}

    #Postconditions
    assert_equal(self.cols,cols)
    assert_equal(self.rows,rows)
  end

  def initialize(cols,rows,dok)
    #Preconditions
    assert(cols>0)
    assert(rows>0)
    assert(dok.is_a?Hash)
    
    @cols,@rows=cols,rows
    @matrix=dok.dup

    #Postconditions
    assert_equal(self.cols,cols)
    assert_equal(self.rows,rows)
    assert_equal(self.matrix,dok)
  end

  def transpose()
    #Preconditions
    assert_equal(self.rows,self.cols)

    result=SparseMatrix.new(self.rows,self.cols,Hash[self.matrix.map{|k,v| [k.reverse,v]}])

    #Postconditions
    assert_equal(result.rows,self.rows)
    assert_equal(result.cols,self.cols)
  end

  def determinant()
    #Preconditions
    assert_equal(self.rows,self.cols)

    (1..cols).map{|i| (i == cols && i == 2 ? 0 : (self.cols == 2 ? self.matrix[[1,1]].to_f*self.matrix[[2,2]].to_f-self.matrix[[1,2]].to_f*self.matrix[[2,1]].to_f : (-1)**(i+1)*self.matrix[[i,1]].to_f*SparseMatrix.new(self.cols-1,self.rows-1,Hash[Hash[self.matrix.reject{|k,v| k[1] == 1 || k[0] == i}].map{|k,v| (k[0] < i ? [[k[0],k[1]-1],v] : [[k[0]-1,k[1]-1],v])}]).determinant))}.reduce(:+)
    
    #LOL

    #Postconditions
    assert(result.respond_to?:to_i)
  end

  def inverse()
    #Preconditions
    assert_equal(self.rows,self.cols)
    assert_not_equal(self.det,0)

    self.cofactorMatrix.transpose.times(1/self.determinant)

    #Postconditions
    assert_equal(self*result,SparseMatrix.identity)
  end
  
  def cofactorMatrix()
	  SparseMatrix.new(self.cols,self.rows,Hash[self.matrix.map{|k,v| [k,self.cofactor(k[0],k[1])]}])
  end
  
  def cofactor(i,j)
	  (-1)**(i+j)*SparseMatrix.new(self.cols-1,self.rows-1,Hash[Hash[self.matrix.reject{|x,y| x[0] == i || x[1] == j}].map{|x,y| (x[0] < i ? (x[1] < j ? [[x[0],x[1]],y] : [[x[0],x[1]-1],y]) : (x[1] < j ? [[x[0]-1,x[1]],y] : [[x[0]-1,x[1]-1],y] ))}]).determinant
  end

  def minor(ri,rf,ci,cf)
    #Preconditions
    assert(ri<self.rows)
    assert(rf<=self.rows)
    assert(ci<self.cols)
    assert(ci<=self.cols)

    result=SparseMatrix.new(cf-ci+1, rf-ri+1, Hash[Hash[self.matrix.reject{|k,v| k[1] < ri || k[1] > rf || k[0] < ci || k[0] > cf}].map{|k,v| [[k[0]-ci+1,k[1]-ri+1],v]}])

    #Postconditions
    assert(self.rows>=result.rows)
    assert(self.cols>=result.cols)
  end

  def real?()
    #Preconditions
    assert(self.matrix!=nil)

    result=self.matrix.values.all?(&:real?)

    #Postconditions
    assert(result.is_a?(TrueClass)||result.is_a?(FalseClass))
  end

  def regular?()
    #Preconditions
    assert(self.matrix!=nil)

    result=!self.singular?

    #Postconditions
    assert(result.is_a?(TrueClass)||result.is_a?(FalseClass))
  end

  def round(digits=0)
    #Preconditions
    assert(self.matrix!=nil)

    result=SparseMatrix.new(self.cols,self.rows,Hash[self.matrix.map{|k,v| [k,v.round(digits)]}])

    #Postconditions
    assert(result.rows==self.rows)
    assert(result.cols==self.cols)
  end

  def singular?()
    #Preconditions
    assert(self.matrix!=nil)
    
    result=self.determinant == 0

    #Postconditions
    assert(result.is_a?(TrueClass)||result.is_a?(FalseClass))
  end

  def trace()
    #Preconditions
    assert(self.matrix!=nil)

    k=(1..rows).map{|i| self.matrix[[i,i]].to_f}.inject(0, &:+)

    #Postconditions
    assert(k.respond_to?:to_i)
  end

  def square?()
    #Preconditions
    assert(self.matrix!=nil)

    result=(self.rows == self.cols)

    #Postconditions
    assert(result.is_a?(TrueClass)||result.is_a?(FalseClass))    
  end

  def symmetric?()
    #Preconditions
    assert(self.matrix!=nil)
    assert(self.square?)

    self.minus(self.transpose).zero?

    #Postconditions
    assert(result.is_a?(TrueClass)||result.is_a?(FalseClass))    
  end

  def zero?()
    #Preconditions
    assert(self.matrix!=nil)

    result=self.matrix.values.all?{|v| v == 0}

    #Postconditions
    assert(result.is_a?(TrueClass)||result.is_a?(FalseClass))
  end

  def identity(size)
    #Preconditions
    assert(size.respond_to?:to_i)

    result=SparseMatrix.new(size, size, Hash[(1..size).map{|i| [[i,i],1]}])

    #Postconditions
    assert(result.rows==result.cols)
    assert(result.cols=size)
    assert_equal(self.trace,k)
  end

  def plus(m)
    #Preconditions
    assert_equal(self.cols,m.cols)
    assert_equal(self,rows,m.rows)

    result=SparseMatrix.new(self.cols,self.rows,self.matrix.merge(m.matrix) {|key, v1, v2| v1+v2})

    #Postconditions
    assert(result.rows==self.rows)
    assert(result.cols==self.cols)
  end

  def minus(m)
    #Preconditions
    assert_equal(self.cols,m.cols)
    assert_equal(self,rows,m.rows)

    result=SparseMatrix.new(self.cols,self.rows,self.matrix.merge(m.negate.matrix) {|key, v1, v2| v1+v2})
    
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

    SparseMatrix.new(self.cols,self.rows,self.matrix.merge(self.matrix) {|key,v1,v2| -v2})

    #Postconditions
    assert(self.matrix!=nil)
  end

  def get(i,j)
    #Preconditions
    assert(i<=self.cols)
    assert(j<=self.rows)
    assert(i>=1)
    assert(j>=1)

    result=self.matrix[[i,j]].to_i

    #Postconditions
    assert(result!=nil)
  end

  def put(i,j,v)
    #Preconditions
    assert(i<=self.cols)
    assert(j<=self.rows)
    assert(v.respond_to?:to_i)

    self.matrix[[i,j]]=v

    #Postconditions
    assert_equal(self[i,j],v)
  end

  def count()
    #Preconditions
    assert(self.matrix!=nil)

    result=self.matrix.size

    #Postconditions
    assert(result!=nil)
  end

  def clear()
    #Preconditions
    assert(self.matrix!=nil)

    #Postconditions
    assert_equal(self.count,0)
  end

  alias + plus
  alias - minus
  alias -@ negate
  alias []= put
  alias set put
  alias [] get
  alias t transpose
  alias det determinant
  alias inv inverse

end

