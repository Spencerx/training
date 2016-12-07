#!/usr/bin/env ruby

require_relative "lib/ant.rb"
require_relative "lib/world.rb"

world = World.new
ant = Ant.new(world)

loop do
  100.times { puts }
  puts world.to_s
  ant.move
  sleep 0.1
end
