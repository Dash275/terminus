require "curses"
require "./message"

module Control
  public
  def self.feed(char, key)
    self.move(char, key) if ("yuhjklbn").include?(key)
  end

  private
  def self.space_valid?(char, y_move, x_move)
    new_y = char.position[0] + y_move
    new_x = char.position[1] + x_move
    if space_out_of_bounds?(new_y, new_x)
      Message.alert("You can't move that way.")
      Curses.setpos(char.position[0], char.position[1])
      return false
    end
    return true
  end

  def self.space_out_of_bounds?(y, x)
    return (y < 0 || y > 24 || x < 0 || x > 80) ? true : false
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
      char.position[0] += y
      char.position[1] += x
    end
  end
end
