require './SparseMatrix'

#Initialize a new matrix in different ways
a=SparseMatrix.new(4,6) #Just the number of columns,rows
b=SparseMatrix.new(5,5,{[1,1]=>6,[2,4]=>-1,[3,5]=>27}) #Size and values
c=SparseMatrix.new(a) #An exisiting SparseMatrix

#Getting the transpose of a matrix
t=a.transpose
t=a.t

#Getting the determinant of a matrix
d=b.determinant
d=b.det

#Other possible methods are performed in similar ways, and can be
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
