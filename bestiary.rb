require "curses"
require "./color"

class Character
  attr_accessor :position
  attr_accessor :image, :color, :style
  attr_accessor :shields, :oxygen

  def draw
    Curses.setpos(@position[0], @position[1])
    Curses.attron(Curses.color_pair(@color)|@style)
    Curses.addstr(@image)
    Curses.attroff(Curses.color_pair(@color)|@style)
    Curses.setpos(@position[0], @position[1])
  end

  def damaged_for(n)
    @shields -= n
  end

  def oxygen_used(n)
    @oxygen -= n
  end
end

class Roland < Character
  def initialize(y,x)
    @position = [y,x]
    @image = ?@
    @color = 46 # True Green
    @style = Curses::A_BOLD
    @shields = 100
    @oxygen = 100
  end
end
