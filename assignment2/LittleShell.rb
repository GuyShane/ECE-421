#!/usr/bin/env ruby
module LittleShell

  def LittleShell.run_shell
    if ARGV.empty?
      input=$stdin
      prompt="LittleShell-$: "
    else
      input=ARGV.join(' ')
      prompt=""
    end

    print prompt
    input.each_line do |line|
      pid = fork {
        exec line
      }
      Process.wait pid
      print prompt
    end
  end

end
