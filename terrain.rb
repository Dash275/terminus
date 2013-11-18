require "curses"
require "./entity"

class Terrain < Entity
  attr_accessor :passable

  def initialize(pos, image, color=Curses::COLOR_WHITE, style=Curses::A_NORMAL,
                 passable=false)
    @position = pos
    @image = image
    @color = color
    @style = style
    @passable = passable
  end
end
