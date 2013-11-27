require "curses"
require "./entity"
require "./control"

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

  def can_see(world)
    floor = Control.floor_player_on(world)
    floor = floor.terrain
    nstop, sstop, wstop, estop = false, false, false, false
    viewable_tiles = []
    (0..@sight_length).each do |point|
      north = @position[0] - point
      south = @position[0] + point
      west = @position[1] - point
      east = @position[1] + point
      if !nstop
        viewable_tiles << [north, @position[1]]
        tile = floor.select {|x| x.position == [north, @position[1]]}
        nstop = true if tile[0].class == Wall
      end
      if !sstop
        viewable_tiles << [south, @position[1]]
        tile = floor.select {|x| x.position == [south, @position[1]]}
        sstop = true if tile[0].class == Wall
      end
      if !wstop
        viewable_tiles << [@position[0], west]
        tile = floor.select {|x| x.position == [@position[0], west]}
        wstop = true if tile[0].class == Wall
      end
      if !estop
        viewable_tiles << [@position[0], east]
        tile = floor.select {|x| x.position == [@position[0], east]}
        estop = true if tile[0].class == Wall
      end
    end
    return viewable_tiles
  end
end
