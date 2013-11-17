require "curses"
require "./entity"

class Character < Entity
  attr_accessor :shields, :oxygen

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
