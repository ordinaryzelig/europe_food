module Coordinates

  module_function

  def all
    @coordinates ||= YAML.load(File.read('location_coordinates.yml'))
  end

  def x(name)
    all.fetch(name)['x']
  end

  def y(name)
    all.fetch(name)['y']
  end

end
