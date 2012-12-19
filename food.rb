class Food

  SIZE               = 500
  PADDING            = 50
  HORIZONTAL_SPACING = SIZE + PADDING
  DATA_Z             = -2_000

  include NamedAfterPath
  include UnderscoredDomId

  attr_reader :path
  attr_reader :name

  def initialize(path, location)
    super(path)
    @location = location
  end

  def src
    path.sub(%r{^\./public/}, '')
  end

  def dom_id
    "#{@location.name}-#{super}"
  end

  def data_x
    @location.data_x + (idx * HORIZONTAL_SPACING)
  end

  def data_y
    @location.data_y
  end

  def data_z
    DATA_Z
  end

  def idx
    @location.idx_for_food(self)
  end

  def step_atts
    {
      'id'           => dom_id,
      'data-x'       => data_x,
      'data-y'       => data_y,
      'data-z'       => data_z,
      'data-location' => @location.dom_id,
    }
  end

end
