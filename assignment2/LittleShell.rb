#!/usr/bin/env ruby

if ARGV.empty?
  input=$stdin
else
  input=ARGV.join(' ')
end

input.each_line do |line|
  pid = fork {
    exec line
  }
  Process.wait pid
end
