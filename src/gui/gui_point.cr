require "lib_gl"
require "crystglfw"
require "../poligons/point"

include CrystGLFW

class GuiPoint
  def initialize(point : Point)
    @point = point
  end

  def draw_point(window : CrystGLFW::Window) : Nil
    LibGL.point_size(8.0)
    LibGL.clear(LibGL::COLOR_BUFFER_BIT | LibGL::DEPTH_BUFFER_BIT)
    LibGL.begin(LibGL::POINTS)
    LibGL.color3f(0.0, 0.0, 0.0);
    LibGL.vertex2f(@point.vector_x(window.size["width"]), @point.vector_y(window.size["height"]));
    LibGL.end
    LibGL.flush
    window.swap_buffers
  end

end