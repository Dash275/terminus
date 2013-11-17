require 'curses'

class Dungeon
  attr_accessor :floors

  def initialize
    @floors = []
  end

  def <<(floor)
    self.floors << floor if floor.class == Floor
  end
end

class Floor
  attr_accessor :terrain, :beasts

  def initialize
    @terrain = []
    @beasts = []
  end

  def <<(entity)
    self.terrain << entity if entity.class == Terrain
    self.beasts << entity if entity.class.ancestors.include?(Character)
  end
end
