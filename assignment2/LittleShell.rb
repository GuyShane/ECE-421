#!/usr/bin/env ruby
require 'shellwords'
require 'getoptlong'
require './DelayPrint'

all_commands=['pwd','mkdir','touch','mv','ls','rm','rmdir','cat','echo','cp','cd','delay_print','FileWatchCreation','FileWatchAlter','FileWatchDestroy']
flags={'ls'=>['--all','-a','-l'],'rm'=>['--recursive','-r','--force','f']}

prompt="LittleShell-$: "

commands={'cd'=>lambda{|newdir| Dir.chdir(newdir)},
  'delay_print'=>lambda{|delay,message| fork{DelayPrint.delay_print(delay.to_i,message)}}
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
    good_command=true
    command,*args=Shellwords.shellsplit(user_in)
    if !all_commands.include? command
      puts "Command #{command} not recognized"
      good_command=false
    end
    args.each {|arg| ARGV << arg};
    opts=GetoptLong.new(
                        ['--all','-a',GetoptLong::NO_ARGUMENT],
                        ['-l',GetoptLong::NO_ARGUMENT],
                        ['--recursive','-r',GetoptLong::NO_ARGUMENT],
                        ['--force','-f',GetoptLong::NO_ARGUMENT]
                        )
    opts.quiet=true
    begin
      opts.each do |opt,arg|
        case opt
        when '--force'
          puts "Permission denied: cannot force command"
          good_command=false
        end
      end
    rescue Exception
      puts "Invalid option passed to command: #{command}"
      good_command=false
    end
    if good_command
      if (commands[command])
        commands[command].call(*args)
      else
        execute(user_in)
      end
    end
  end
else
  #Need to make this safer later
  input=ARGV.join(' ')
  execute(input)
end
