require "curses"
require "./message"

module Control
  public
  def self.player_look(char, world)
    floor = self.floor_player_on(world)
    viewable_tiles = char.can_see
    viewable_tiles.each do |coordinate|
      floor.terrain.each do |tile|
        tile.seen = true if tile.position == coordinate
      end
    end
  end

  def self.feed(world, char, key)
    player_floor = floor_player_on(world)
    self.move(player_floor, char, key) if ("yuhjklbn").include?(key)
  end

  private
  def self.floor_player_on(world)
    floor = nil
    world.floors.each do |f|
      floor = f if f.beasts.any? {|x| x.class == Roland}
    end
    return floor
  end

  def self.space_valid?(floor, char, y_move, x_move)
    new_y = char.position[0] + y_move
    new_x = char.position[1] + x_move
    if space_out_of_bounds?(new_y, new_x)
      Message.alert("Eat the path.")
      Curses.setpos(char.position[0], char.position[1])
      return false
    end
    if space_blocked?(floor, new_y, new_x)
      Message.alert("That path is blocked.")
      Curses.setpos(char.position[0], char.position[1])
      return false
    end
    return true
  end

  def self.space_out_of_bounds?(y, x)
    return (y < 0 || y > 24 || x < 0 || x > 80) ? true : false
  end

  def self.space_blocked?(floor, y, x)
    new_pos = [y, x]
    floor.terrain.each do |entity|
      if entity.position == new_pos && entity.passable == false
        return true
      end
    end
    return false
  end

  def self.move(player_floor, char, key)
    y, x = -1, -1 if key == "y"
    y, x = -1, 1 if key == "u"
    y, x = 0, -1 if key == "h"
    y, x = 1, 0 if key == "j"
    y, x = -1, 0 if key == "k"
    y, x = 0, 1 if key == "l"
    y, x = 1, -1 if key == "b"
    y, x = 1, 1 if key == "n"
    if self.space_valid?(player_floor, char, y, x)
      char.position[0] += y
      char.position[1] += x
    end
  end
end
