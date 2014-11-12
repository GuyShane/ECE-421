=begin
Shane Brass
Mujda Abbasi

This file shows examples of how to run the module with either
a file as input or a ruby array. The module can also verify that a given
array is in ascending order.

The format for sorting is
Sorter.sort(timeout,list), where timeout is a time in seconds and list
is a list of numbers

Testing a sort can be done with
Sorter.sorted? list
=end

require './Sorter'
a=[]
100.times {a << rand(100)}
sortedFile=Sorter.sort(10,"test.txt")
sorted=Sorter.sort(10,a)
Sorter.sorted? sorted
