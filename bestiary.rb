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
    @sight_length = 4
    @seen = true
  end

  def can_see
    viewable_tiles = []
    (0..@sight_length).each do |point|
      north = @position[0] - point
      south = @position[0] + point
      west = @position[1] - point
      east = @position[1] + point
      viewable_tiles << [north, @position[1]]
      viewable_tiles << [south, @position[1]]
      viewable_tiles << [@position[0], west]
      viewable_tiles << [@position[0], east]
      #curve_len = @sight_length - point)
      #(1..curve_len).each do |point_2|
      #  viewable_tiles << [+ point_2, west]
      #  viewable_tiles << [- point_2, west]
      #  viewable_tiles << [+ point_2, east]
      #  viewable_tiles << [- point_2, east]
      #end
    end
    return viewable_tiles
  end
end
