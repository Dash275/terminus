#!/usr/local/bin/ruby

require "curses"
include Curses

module Message
  private
  def self.full_box(&block)
    full_box = Window.new(lines, cols, 0, 0)
    full_box.box(?|, ?-)
    full_box.refresh
    yield if block_given?
    full_box.close
    refresh
  end

  public
  def self.pop_up(h, w, x, y, message)
    text_box = Window.new(h, w, x, y)
    text_box.box(?|, ?-)
    text_area = Window.new((h - 2), (w - 2), x + 1, y + 1)
    text_area.setpos(0,0)
    text_area.addstr(message)
    text_box.refresh
    text_area.refresh
    text_box.getch
    text_box.close
    text_area.close
    refresh
  end

  def self.full_screen(message)
    Message.full_box do
      terminal = Window.new((lines - 2), (cols - 2), 1, 1)
      terminal.addstr(message)
      terminal.refresh
      terminal.getch
      terminal.close
      refresh
    end
  end
end
