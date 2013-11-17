require "curses"
require "./color"

class Terrain
  attr_accessor :position
  attr_accessor :image, :color, :style

  def initialize(pos, image, color=Curses::COLOR_WHITE, style=Curses::A_NORMAL)
    @position = pos
    @image = image
    @color = color
    @style = style
  end

  def draw
    Curses.setpos(@position[0], @position[1])
    Curses.attron(Curses.color_pair(@color)|@style)
    Curses.addstr(@image)
    Curses.attroff(Curses.color_pair(@color)|@style)
    Curses.setpos(@position[0], @position[1])
  end
end
