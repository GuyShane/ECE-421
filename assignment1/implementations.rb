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

  

  def transpose()
    SparseMatrix.new(self.rows,self.cols,Hash[self.matrix.map{|k,v| [k.reverse,v]}])
  end

  def plus(m)
    SparseMatrix.new(self.cols,self.rows,self.matrix.merge(m.matrix) {|key, v1, v2| v1+v2})
  end

  def minus(m)
    SparseMatrix.new(self.cols,self.rows,self.matrix.merge(m.negate.matrix) {|key, v1, v2| v1+v2})
  end

  def times(m)
    result=SparseMatrix.new(self.cols,m.rows)
    (0..m.cols).each do |i|
      (0..self.rows).each do |j|
        (0..self.cols).each do |k|
          result[j,i]+=self[j,k]*m[k,i]
        end
      end
    end
    result.matrix.reject!{|k,v| v==0} 
    return result
  end

  def negate()
    SparseMatrix.new(self.cols,self.rows,self.matrix.merge(self.matrix) {|key,v1,v2| -v2})
  end

  def get(i,j)
    self.matrix[[i,j]].to_i
  end

  def put(i,j,v)
    self.matrix[[i,j]]=v
  end

  def count()
    self.matrix.size
  end

  alias + plus
  alias - minus
  alias -@ negate
  alias []= put
  alias set put
  alias [] get
  alias t transpose

end
