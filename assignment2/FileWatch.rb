#!usr/bin/ruby

require 'rb-inotify'
require_relative 'Delay'

module FileWatch

  def FileWatch.creation(duration, *args, &block)
    notifier = INotify::Notifier.new
    args.each do |file|
      notifier.watch(file, :moved_to, :create){Delay.delay(time);}
    end
    notifier.run
  end

  def FileWatch.destroy(duration, *args, &block)
    notifier = INotify::Notifier.new
    args.each do |file|
	notifier.watch(file, :delete){puts }
    end
    notifier.run
  end

  def FileWatch.alter(duration, *args, &block)
    notifier = INotify::Notifier.new
    args.each do |file|
	notifier.watch(file, ){puts }
    end
    notifier.run
  end

end
