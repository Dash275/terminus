require "curses"

module Message
  private
  def self.full_box(&block)
    full_box = Curses::Window.new(Curses.lines, Curses.cols, 0, 0)
    full_box.box(?|, ?-)
    full_box.refresh
    yield if block_given?
    full_box.close
    Curses.refresh
  end

  public
  def self.alert(message)
    Curses.setpos(0,0)
    Curses.addstr(message)
    Curses.getch
  end

  def self.pop_up(h, w, y, x, message)
    text_box = Curses::Window.new(h, w, y, x)
    text_box.box(?|, ?-)
    text_area = Curses::Window.new((h - 2), (w - 2), y + 1, x + 1)
    text_area.setpos(0,0)
    text_area.addstr(message)
    text_box.refresh
    text_area.refresh
    text_box.getch
    text_box.close
    text_area.close
    Curses.refresh
  end

  def self.full_screen(message)
    Message.full_box do
      box = Curses::Window.new((Curses.lines - 2), (Curses.cols - 2), 1, 1)
      box.addstr(message)
      box.refresh
      box.getch
      box.close
      Curses.refresh
    end
  end
end
