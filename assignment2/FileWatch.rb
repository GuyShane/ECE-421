#!usr/bin/ruby

require 'inotify'

module FileWatch

  def creation(duration, *args)
    notifier = Inotify.new
    args.each do |file|
      notifier.add_watch(file, Inotify::MOVE, Inotify::CREATE)
    end
  end

  def alter(duration, *args)
    notifier = Inotify.new
    args.each do |file|
      if File.directory? file
        notifier.add_watch(file,

end  