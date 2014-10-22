#!/usr/bin/env ruby
require 'shellwords'

prompt="LittleShell-$: "

commands={'cd'=>lambda{|newdir| Dir.chdir(newdir)},
  'delay_print'=>lambda{|delay,message| execute("(sleep #{delay} && echo "" && echo \"#{message}\") &")}
}

def execute(command)
  pid=fork {exec command}
  Process.wait pid
end

if ARGV.empty?
  input=$stdin
  loop do
    $stdout.print prompt
    user_in=input.gets.strip
    command,*args=Shellwords.shellsplit(user_in)
    if (commands[command])
      commands[command].call(*args)
    else
      execute(user_in)
    end
  end
else
  #Need to make this safer later
  input=ARGV.join(' ')
  execute(input)
end



