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

  def generate_room(pos, h, w, color=237)
    return false if h <= 6 || w <= 8
    return false if h >= 12 || w >= 16
    y, x = pos[0], pos[1]
    y_two, x_two = y + h - 1, x + w - 1
    (y..y_two).each do |y_pt|
      (x..x_two).each do |x_pt|
        return false if @terrain.any? {|x| x.position == [y_pt, x_pt]}
      end
    end
    new_terrain = []
    (y..y_two).each do |y_pt|
      (x..x_two).each do |x_pt|
        if y_pt == y || y_pt == y_two
          new_terrain << Wall.new([y_pt, x_pt], color)
        elsif x_pt == x || x_pt == x_two
          new_terrain << Wall.new([y_pt, x_pt], color)
        else
          new_terrain << Ground.new([y_pt, x_pt], color)
        end
      end
    end
    new_terrain.each {|x| @terrain << x}
    return true
  end

  def generate_floor(color=237)
    rooms = 0
    loop do
      break if rooms == 8
      x_one = Random.rand(0..80)
      x_two = Random.rand(x_one..80)
      w = x_two - x_one
      y_one = Random.rand(0..24)
      y_two = Random.rand(y_one..24)
      h = y_two - y_one
      success = true if generate_room([y_one, x_one], h, w, color)
      rooms += 1 if success
    end
  end

  def player_start
    grounds = @terrain.select {|x| x.class == Ground}
    start = grounds.sample
    #Curses.close_screen
    #puts pos.inspect
    #exit
    @beasts << player = Roland.new(start.position[0], start.position[1])
    return player
  end

  def draw
    @terrain.each {|x| x.draw}
    @beasts.each {|x| x.draw}
  end
end
