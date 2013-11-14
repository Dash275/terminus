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
    if    key == "y" && self.space_valid?(char, -1, -1)
      char.position[1] += -1
      char.position[0] += -1
    elsif key == "u" && self.space_valid?(char, -1, 1)
      char.position[1] += -1
      char.position[0] +=  1
    elsif key == "h" && self.space_valid?(char, 0, -1)
      char.position[0] += -1
    elsif key == "j" && self.space_valid?(char, 1, 0)
      char.position[1] +=  1
    elsif key == "k" && self.space_valid?(char, -1, 0)
      char.position[1] += -1
    elsif key == "l" && self.space_valid?(char, 0, 1)
      char.position[0] +=  1
    elsif key == "b" && self.space_valid?(char, 1, -1)
      char.position[1] +=  1
      char.position[0] += -1
    elsif key == "n" && self.space_valid?(char, 1, 1)
      char.position[1] +=  1
      char.position[0] +=  1
    end
  end
end
