require "curses"
require "./entity"

class Terrain < Entity
  attr_accessor :passable
end

class Wall < Terrain
  def initialize(pos, color=237)
    @position = pos
    @image = ?#
    @color = color
    @style = Curses::A_NORMAL
    @passable = false
  end
end

class Ground < Terrain
  def initialize(pos, color=237)
    @position = pos
    @image = ?.
    @color = color
    @style = Curses::A_NORMAL
    @passable = true
  end
end

class Liquid < Terrain
  def initialize(pos, color=19)
    @position = pos
    @image = ?~
    @color = color
    @style = Curses::A_NORMAL
    @passable = true
  end
end
