require "curses"

class Character
  attr_accessor :position
  attr_accessor :image
  attr_accessor :shields, :oxygen

  def draw
    Curses.setpos(@position[0], @position[1])
    Curses.addstr(@image)
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
    @shields = 100
    @oxygen = 100
  end
end
