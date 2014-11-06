def readFile(filename)
  file=File.new(filename,"r")
  list=[]
  while (line=file.gets)
    list << line.strip.to_i
  end
  file.close
  return list
end

def merge(a,b)
  r = []
  r << Thread.new{(a.first < b.first ? a : b).shift while a.length*b.length > 0}
  return r+a+b
end

def tmerge(a,b,c)
  if (b.length>a.length)
    thread1=Thread.new{tmerge(b,a,c)}
    thread1.join
    return thread1.value
  elsif (a.length+b.length==1)
    c << a[0]
    return c
  elsif (a.length==1)
    if a[0]<=b[0]
      c[0]=a[0]
      c[1]=b[0]
      return c
    else
      c[0]=b[0]
      c[1]=a[0]
      return c
    end
  else
    j=binsearch(a[a.length/2],b)
    thread2=Thread.new{tmerge(a.take(a.length/2),b.take(j),c)}
    thread3=Thread.new{tmerge(a.drop(a.length/2),b.drop(j),c)}
    thread2.join
    thread3.join
    return thread2.value+thread3.value
  end
end

def binsearch(x,b)
  
end


def mergesort(list)
  return list if list.size == 1
  a = Thread.new{mergesort(list[0, list.size/2])}
  b = Thread.new{mergesort(list[list.size/2, list.size])}
  a.join
  b.join
  c=[]
  return merge(a.value, b.value,c)
end

module Sorter

  def Sorter.sort(*args,&block)
    begin
      duration=args[0]
      begin
        array=readFile(args[1])
      rescue Exception
        array=args[1]
      end
    rescue Exception
      puts "Failed to parse arguments passed to sort"
      return
    end
    sorted=mergesort(array)
    print sorted
  end

  def Sorter.sorted?(list,&block)

  end

end
