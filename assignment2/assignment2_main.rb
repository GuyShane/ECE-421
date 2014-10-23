#!/usr/bin/env ruby
=begin
Mujda Abbasi
Shane Brass

This file runs the shell file, which will enter the user into the shell.
This needs to be executed on top of bash, or a bash like shell, as the
commands are executed on the underlying shell.
The available commands => flags are:

ls=> --all,-a,-l,
rm=> --recursive,-r,--force,-f
pwd
mkdir
echo=> -e,-n
cp
cd
touch
delay_print [duration (ms)] [message]
FileWatchCreation [duration (ms)] [file] {[block]}
FileWatchAlter [duration (ms)] [file] {[block]}
FileWatchDestroy [duration (ms)] [file] {[block]}
=end
exec "./LittleShell.rb"
