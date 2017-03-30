class Food

  IMAGE_PATH = 'public/images/foods'

  attr_reader :path
  attr_reader :name
  attr_reader :location

  def initialize(path, location)
    @location = location
    @path = path
    @name =
      path
        .split('/')
        .last
        .sub('.jpg', '')
  end

end
