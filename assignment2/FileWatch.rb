#!usr/bin/ruby

require 'rb-inotify'
require './Delay'

module FileWatch

  def FileWatch.creation(duration, *args, block)
    notifier = INotify::Notifier.new
    args.each do |file|
      notifier.watch(file, :moved_to, :create){fork{Delay.delay(duration.to_i);eval(block);print "\nLittleShell-$: "}}
    end
    notifier.run
  end

  def FileWatch.destroy(duration, *args, block)
    notifier = INotify::Notifier.new
    args.each do |file|
	notifier.watch(file, :delete){fork{Delay.delay(duration.to_i);eval(block);print "\nLittleShell-$: "}}
    end
    notifier.run
  end

  def FileWatch.alter(duration, *args, block)
    notifier = INotify::Notifier.new
    args.each do |file|
	notifier.watch(file, :access, :attrib, :modify, :delete){fork{Delay.delay(duration.to_i);eval(block);print "\nLittleShell-$: "}}
    end
    notifier.run
  end

end
