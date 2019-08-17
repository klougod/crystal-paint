class Point
  def initialize(xpos : Float64, ypos : Float64)
    @xpos = xpos
    @ypos = ypos
  end

  def vector_x(window_width : Int32)
    return ((x-window_width/2)/window_width)*2
  end 

  def vector_y(window_height : Int32)
    return ((x-window_height/2)/window_height)*-2
  end 

end