class Food

  SIZE               = 500
  PADDING            = 50
  HORIZONTAL_SPACING = SIZE + PADDING
  DATA_Z             = -2_000

  include NamedAfterPath
  include UnderscoredDomId

  attr_reader :path

  def initialize(path, country)
    super(path)
    @country = country
  end

  def src
    path.sub(%r{^\./public/}, '')
  end

  def name
    @name.sub('.jpg', '')
  end

  def data_x
    @country.data_x + (idx * HORIZONTAL_SPACING)
  end

  def data_y
    @country.data_y
  end

  def data_z
    DATA_Z
  end

  def idx
    @country.idx_for_food(self)
  end

  def step_atts
    {
      'id'           => dom_id,
      'data-x'       => data_x,
      'data-y'       => data_y,
      'data-z'       => data_z,
      'data-country' => @country.dom_id,
    }
  end

end
