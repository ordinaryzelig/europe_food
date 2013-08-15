module UnderscoredDomId

  def dom_id
    @name.gsub(/\W/, '_')
  end

end
