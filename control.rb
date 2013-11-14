#!/usr/local/bin/ruby

module Control
  public
  def self.feed(char, key)
    self.move(char, key) if ("yuhjklbn").include?(key)
  end

  private
  def self.space_valid?(char, y_move, x_move)
    new_y = char.position[1] + y_move
    new_x = char.position[0] + x_move
    if new_y >= 0 && new_x >= 0
      return true
    end
    return false
  end

  def self.move(char, key)
    y, x = -1, -1 if key == "y"
    y, x = -1, 1 if key == "u"
    y, x = 0, -1 if key == "h"
    y, x = 1, 0 if key == "j"
    y, x = -1, 0 if key == "k"
    y, x = 0, 1 if key == "l"
    y, x = 1, -1 if key == "b"
    y, x = 1, 1 if key == "n"
    if self.space_valid?(char, y, x)
      char.position[1] += y
      char.position[0] += x
    end
  end
end
