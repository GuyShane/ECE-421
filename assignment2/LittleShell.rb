#!/usr/bin/env ruby
require 'shellwords'
require 'getoptlong'
require './Delay'
require './FileWatch'

command_flags={'ls'=>['--all','-a','-l'],'rm'=>['--recursive','-r','--force','-f'],'pwd'=>[],'mkdir'=>[],
  'echo'=>['-e','-n'],'cp'=>[],'cd'=>[],'delay_print'=>[],'FileWatchCreation'=>[],'FileWatchAlter'=>[],'FileWatchDestroy'=>[],
  'touch'=>[]}

prompt="LittleShell-$: "

commands={'cd'=>lambda{|newdir| Dir.chdir(newdir)},
  'delay_print'=>lambda{|delay,message| fork{Delay.delay_print(delay.to_i,message)}},
  'FileWatchCreation'=>lambda{|duration,files,block| fork{FileWatch.creation(duration,files,block.tr('{}',''))}},
  'FileWatchDestroy'=>lambda{|duration,files,block| fork{FileWatch.destroy(duration,files,block.tr('{}',''))}},
  'FileWatchAlter'=>lambda{|duration,files,block| fork{FileWatch.alter(duration,files,block.tr('{}',''))}}
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
    reg_split=user_in.partition(/{.*}/)
    user_in=reg_split[0]
    block=reg_split[1]
    command,*args=Shellwords.shellsplit(user_in)
    args << block
    args.delete("")
    if !command_flags.include? command
      puts "Command #{command} not recognized"
      good_command=false
    end
    args.each {|arg| ARGV << arg};
    opts=GetoptLong.new(
                        ['--all','-a',GetoptLong::NO_ARGUMENT],
                        ['-l',GetoptLong::NO_ARGUMENT],
                        ['--recursive','-r',GetoptLong::NO_ARGUMENT],
                        ['--force','-f',GetoptLong::NO_ARGUMENT],
                        ['-n',GetoptLong::NO_ARGUMENT],
                        ['-e',GetoptLong::NO_ARGUMENT]                        
                        )
    opts.quiet=true
    begin
      opts.each do |opt,arg|
        if !command_flags[command].include? opt
          puts "Invalid option passed to command: #{command}"
          good_command=false
        end
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
  input=ARGV.join(' ')
  execute(input)
end
