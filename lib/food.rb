class Food

  include UnderscoredDomId

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

  def src
    path.sub(%r{^\./public/}, '')
  end

  def dom_id
    "#{@location.name}-#{super}"
  end

end
