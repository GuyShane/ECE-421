class SparseMatrix

  attr_reader :rows, :cols, :matrix

  def initialize(*args)
    if args.size==1
      puts args
      @rows=args[0].rows
      @cols=args[0].cols
      @matrix=args[0].matrix.dup
    elsif args.size==2
      @cols,@rows=args
      @matrix={}
    else
      @cols,@rows=args
      @matrix=args[2].dup
    end
  end

=begin
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
=end

  def transpose()
  	#Returns the transpose of the matrix
    SparseMatrix.new(self.rows,self.cols,Hash[self.matrix.map{|k,v| [k.reverse,v]}])
  end

  def determinant()
    #Calculates and returns the determinant of the matrix
    (1..cols).map{|i| (i == cols && i == 2 ? 0 : (self.cols == 2 ? self.matrix[[1,1]].to_f*self.matrix[[2,2]].to_f-self.matrix[[1,2]].to_f*self.matrix[[2,1]].to_f : (-1)**(i+1)*self.matrix[[i,1]].to_f*SparseMatrix.new(self.cols-1,self.rows-1,Hash[Hash[self.matrix.reject{|k,v| k[1] == 1 || k[0] == i}].map{|k,v| (k[0] < i ? [[k[0],k[1]-1],v] : [[k[0]-1,k[1]-1],v])}]).determinant))}.reduce(:+)
  end

  def inverse()
    #Returns the inverse matrix
    self.cofactorMatrix.transpose.times(1/self.determinant)
  end
  
  def cofactorMatrix()
  	#Returns the cofactor matrix
    SparseMatrix.new(self.cols,self.rows,Hash[self.matrix.map{|k,v| [k,self.cofactor(k[0],k[1])]}])
  end
  
  def cofactor(i,j)
  	#Calculates and returns the cofactor of an entry in the matrix
    (-1)**(i+j)*SparseMatrix.new(self.cols-1,self.rows-1,Hash[Hash[self.matrix.reject{|x,y| x[0] == i || x[1] == j}].map{|x,y| (x[0] < i ? (x[1] < j ? [[x[0],x[1]],y] : [[x[0],x[1]-1],y]) : (x[1] < j ? [[x[0]-1,x[1]],y] : [[x[0]-1,x[1]-1],y] ))}]).determinant
  end

  def minor(ri,rf,ci,cf)
    #Returns a submatrix of the matrix given ranges of rows and columns using ri (first row), rf (last row), ci (first column), and cf (last column).
    SparseMatrix.new(cf-ci+1, rf-ri+1, Hash[Hash[self.matrix.reject{|k,v| k[1] < ri || k[1] > rf || k[0] < ci || k[0] > cf}].map{|k,v| [[k[0]-ci+1,k[1]-ri+1],v]}])
  end

  def real?()
    #Checks if all the entries in a matrix are real numbers. Returns a boolean value.
    self.matrix.values.all?(&:real?)
  end

  def regular?()
  	#Checks if a matrix is regular(invertible). Returns a boolean values.
    !self.singular?
  end

  def round(digits=0)
  	#Rounds all the entries in the matrix to specified number of digits. Returns a new matrix.
    SparseMatrix.new(self.cols,self.rows,Hash[self.matrix.map{|k,v| [k,v.round(digits)]}])
  end

  def singular?()
    #Checks if a matrix is singular. Returns a boolean value.
    self.determinant == 0
  end

  def trace()
    #Returns the sum of the entries in the main diagonal
    (1..rows).map{|i| self.matrix[[i,i]].to_f}.inject(0, &:+)
  end

  def square?()
  	#Checks of the number fo rows are equal to number of columns. Returns a boolean value.
    (self.rows == self.cols)
  end

  def symmetric?()
  	#Checks if the matrix is symmetric. Returns a boolean value.
    self.minus(self.transpose).zero?  
  end

  def zero?()
    #Checks if all the entries in the matrix are zero. Returns a boolean value.
    result=self.matrix.values.all?{|v| v == 0}
  end

  def SparseMatrix.identity(size)
  	#Returns an identity matrix with dimensions size x size
    SparseMatrix.new(size, size, Hash[(1..size).map{|i| [[i,i],1]}])
  end

  def plus(m)
    #Matrix addition. Returns a new matrix
    SparseMatrix.new(self.cols,self.rows,self.matrix.merge(m.matrix) {|key, v1, v2| v1+v2})
  end

  def minus(m)
    #Matrix subtraction. Returns a new matrix
    SparseMatrix.new(self.cols,self.rows,self.matrix.merge(m.negate.matrix) {|key, v1, v2| v1+v2})
  end

  def times(m)
    #Either matrix or scalar multiplications
    #Returns a new matrix
    case(m)
      when Numeric
      result=SparseMatrix.new(self.cols,self.rows)
      self.matrix.each {|k,v| result[k[0],k[1]]=v*m}
      when SparseMatrix
      result=SparseMatrix.new(self.cols,m.rows)
      (0..m.cols).each do |i|
        (0..self.rows).each do |j|
          (0..self.cols).each do |k|
            result[j,i]+=self[j,k]*m[k,i]
          end
        end
      end
      result.matrix.reject!{|k,v| v==0} 
    end
    return result
  end

  def exp(k)
    #Matrix exponentiation. Must be done on a square matrix
    result=self.dup
    k.times {result=result*self}
  end

  def negate!()
    #Negates all the elements in the matrix
    SparseMatrix.new(self.cols,self.rows,self.matrix.merge(self.matrix) {|key,v1,v2| -v2})
  end

  def get(i,j)
    #Returns the value in the matrix at position[i,j]
    #If there is no value there, it returns 0
    result=self.matrix[[i,j]].to_i
  end

  def put(i,j,v)
    #Puts the value v into the matrix at position [i,j]
    self.matrix[[i,j]]=v
  end

  def count()
    #Returns the number of non zero elements in the matrix
    result=self.matrix.size
  end

  def clear!()
    #Clears the contents of the matrix.
    #Leaves the dimensions the same
    @matrix={}
  end

  alias + plus
  alias - minus
  alias -@ negate!
  alias []= put
  alias set put
  alias [] get
  alias t transpose
  alias * times
  alias det determinant
  alias inv inverse

end

