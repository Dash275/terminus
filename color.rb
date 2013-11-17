require "curses"

Curses.start_color

(1..255).each do |color|
  Curses.init_pair(color, color, Curses::COLOR_BLACK)
end
