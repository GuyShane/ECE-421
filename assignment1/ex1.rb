def fill_list(list,num)
  i=0
  while i<num
    list.push(i)
    i+=1
  end
end

numbers=[]

fill_list(numbers,10)
numbers.each do |num|
  print "#{num} "
end
puts ""
