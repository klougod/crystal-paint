require "lib_gl"
require "lib_glfw"
require "crystglfw"
require "./helpers/constants"

include CrystGLFW

class Main

  @@window_width = 800
  @@window_height = 600

  def self.mb_cb(window : CrystGLFW::Window, xpos : Float64, ypos : Float64) : Nil
    LibGL.point_size(8.0)
    LibGL.clear(LibGL::COLOR_BUFFER_BIT | LibGL::DEPTH_BUFFER_BIT)
    LibGL.begin(LibGL::POINTS)
    LibGL.color3f(0.0, 0.0, 0.0);
    LibGL.vertex2f(xpos, ypos);
    LibGL.end
    LibGL.flush
    window.swap_buffers
  end

  def self.run()

    CrystGLFW.run do

      # Create a new window.
      window = Window.new(width: @@window_width, height: @@window_height, title: "Crystal Paint")

      # Make the window the current OpenGL context.
      window.make_context_current

      window.cursor(Window::Cursor::Shape::Crosshair)

      window.on_resize do |event|
        @@window_width = event.size["width"]
        @@window_height = event.size["height"]
        LibGL.clear(LibGL::COLOR_BUFFER_BIT | LibGL::DEPTH_BUFFER_BIT)
        window.swap_buffers
      end

      window.on_mouse_button do |event|
        mouse_button = event.mouse_button
        if event.action.press? && mouse_button.left?
          x = 0.0
          y = 0.0
          LibGLFW.get_cursor_pos(window.to_unsafe, pointerof(x), pointerof(y))

          xpos = ((x-@@window_width/2)/@@window_width)*2
          ypos = ((y-@@window_height/2)/@@window_height)*-2

          mb_cb(window, xpos, ypos)
        end  
      end

      LibGL.clear_color(1.0, 1.0, 1.0, 1.0)
      LibGL.clear(LibGL::COLOR_BUFFER_BIT | LibGL::DEPTH_BUFFER_BIT)
      window.swap_buffers

      until window.should_close?
        CrystGLFW.poll_events
      end

      window.destroy
    end
  end
end

Main.run