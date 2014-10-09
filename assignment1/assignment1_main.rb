require './SparseMatrix'
#Initialize a new matrix in different ways
a=SparseMatrix.new(4,6) #Just the number of columns,rows
b=SparseMatrix.new(5,5,{[1,1]=>6,[2,4]=>-1,[3,5]=>27}) #Size and values
c=SparseMatrix.new(a) #An exisiting SparseMatrix
i=SparseMatrix.identity(5) #An identity matrix
#Getting the transpose of a matrix
t=a.transpose
t=a.t
#Getting the determinant of a matrix
d=b.determinant
d=b.det
#Getting the inverse of a matrix
e=b.inverse
e=b.inv
#Getting the cofactor matrix
f=b.cofactorMatrix
#Getting the cofactor of an entry in a matrix
cf=b.cofactor(1,1)
#Getting the minor (a submatrix) of a matrix
m=b.minor(2,5,2,3)
#Rounding all entries to specified number of digits
r=b.round(2)
#Finding the trace of a matrix
t=b.trace

#Getting the 
#All these methods can be
#found in SparseMatrix.rb, or by running
#puts a.methods
#Standard matrix arithmetic. Both method calls and
#symbols are valid
sum=b.plus(b)
sum=b+b
#Matrix and scalar multiplication possible
p=a*a
p=a*5
#Getting and setting elements in the matrix
num=a[1,1]
a[1,1]=5
