require "curses"
require "./color"

class Entity
  attr_accessor :position, :image, :color, :style

  def draw
    Curses.setpos(@position[0], @position[1])
    Curses.attron(Curses.color_pair(@color)|@style)
    Curses.addstr(@image)
    Curses.attroff(Curses.color_pair(@color)|@style)
    Curses.setpos(@position[0], @position[1])
  end
end
