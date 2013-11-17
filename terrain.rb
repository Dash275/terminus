require "curses"
require "./entity"

class Terrain < Entity
  def initialize(pos, image, color=Curses::COLOR_WHITE, style=Curses::A_NORMAL)
    @position = pos
    @image = image
    @color = color
    @style = style
  end
end
