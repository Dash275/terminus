#!/usr/local/bin/ruby

require "curses"
include Curses

class Character
  attr_accessor :position
  attr_accessor :image
  attr_accessor :shields, :oxygen

  def draw
    setpos(@position[1], @position[0])
    addstr(@image)
    setpos(@position[1], @position[0])
  end

  def damaged_for(n)
    @shields -= n
  end

  def oxygen_used(n)
    @oxygen -= n
  end
end

class Roland < Character
  def initialize(x,y)
    @position = [x,y]
    @image = ?@
    @shields = 100
    @oxygen = 100
  end
end
