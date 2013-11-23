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
  attr_accessor :rooms

  def initialize
    @terrain, @beasts = [], []
    @rooms = []
  end

  def <<(entity)
    @rooms << entity if entity.class.ancestors.include?(Room)
    @terrain << entity if entity.class.ancestors.include?(Terrain)
    @beasts << entity if entity.class.ancestors.include?(Character)
  end

  def create_floor(color=237)
    (0..79).each do |x|
      (0..21).each do |y|
        @terrain << Wall.new([y,x], color)
      end
    end
  end

  def carve(y, x, object)
    tile = @terrain.select {|entity| entity.position == [y,x]}
    @terrain.delete_if {|entity| entity.position == [y,x]}
    @terrain << object.new([y,x], tile[0].color)
  end

  def create_room(y, x, h, w)
    new_room = Room.new(y, x, h, w)
    return false if @rooms.any? {|room| rooms_intersect?(room, new_room)}
    @rooms << new_room
    (new_room.x_one..new_room.x_two).each do |x|
      (new_room.y_one..new_room.y_two).each do |y|
        carve(y, x, Ground)
      end
    end
    return true
  end

  def create_h_tunnel(x_one, x_two, y)
    line = [x_one, x_two]
    line.sort!
    (line[0]..(line[1] + 1)).each do |x|
      carve(y, x, Ground)
    end
  end

  def create_v_tunnel(y_one, y_two, x)
    line = [y_one, y_two]
    line.sort!
    (line[0]..(line[1] + 1)).each do |y|
      carve(y, x, Ground)
    end
  end

  def rooms_intersect?(a, b)
    return true if a.xa <= b.xb && a.xb >= b.xa && a.ya <= b.yb &&
                   a.yb >= b.ya
    return false
  end

  def generate_floor(color=237)
    create_floor(color)
    # generation technique adapted from Python + libcotd RL tutorial at
    # roguebasin.roguelikedevelopment.org/
    25.times do |room|
      h = Random.rand(5..10)
      w = Random.rand(5..10)
      x = Random.rand(1..(79 - w))
      y = Random.rand(1..(21 - h))
      create_room(y, x, h, w)
      if @rooms.length > 1
        # z and m representing last and second to last room
        rev_rooms = @rooms.reverse
        z_pos = rev_rooms[0].center
        m_pos = rev_rooms[1].center
        if Random.rand(0..1) == 1
          create_h_tunnel(m_pos[1], z_pos[1], m_pos[0])
          create_v_tunnel(m_pos[0], z_pos[0], z_pos[1])
        else
          create_v_tunnel(m_pos[0], z_pos[0], m_pos[1])
          create_h_tunnel(m_pos[1], z_pos[1], z_pos[0])
        end
      end
    end
  end

  def player_start
    grounds = @terrain.select {|x| x.class == Ground}
    start = grounds.sample
    @beasts << player = Roland.new(start.position[0], start.position[1])
    return player
  end

  def draw
    @terrain.each {|x| x.draw}
    @beasts.each {|x| x.draw}
  end
end

class Room
  attr_reader :y_one, :x_one, :y_two, :x_two
  attr_reader :ya, :xa, :yb, :xb

  def initialize(y, x, h, w)
    @y_one = y
    @x_one = x
    @y_two = y + h - 1
    @x_two = x + w - 1

    @ya = y - 1
    @xa = x - 1
    @yb = y_two + 1
    @xb = x_two + 1
  end

  def center
    center_y = (@y_one + @y_two) / 2
    center_x = (@x_one + @x_two) / 2
    return [center_y, center_x]
  end
end
