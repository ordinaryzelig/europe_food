module NamedAfterPath

  def initialize(path)
    @path = path
    @name =
      path
        .split('/')
        .last
        .sub('.jpg', '')
  end

end
