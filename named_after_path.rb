module NamedAfterPath

  def initialize(path)
    @path        = path
    @name        = path.split('/').last
  end

end
