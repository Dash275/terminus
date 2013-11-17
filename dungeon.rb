require 'curses'

class Dungeon
  attr_accessor :floors

  def initialize
    @floors = []
  end

  def <<(floor)
    @floors << floor if floor.class == Floor
  end

  def draw
    @floors.each do |floor|
      break if !floor.beasts.any? {|char| char.class == Roland}
      floor.draw
    end
  end

  def draw_floor(n)
    @floors[n].draw
  end
end

class Floor
  attr_accessor :terrain, :beasts

  def initialize
    @terrain, @beasts = [], []
  end

  def <<(entity)
    @terrain << entity if entity.class.ancestors.include?(Terrain)
    @beasts << entity if entity.class.ancestors.include?(Character)
  end

  def draw
    @terrain.each {|x| x.draw}
    @beasts.each {|x| x.draw}
  end
end
