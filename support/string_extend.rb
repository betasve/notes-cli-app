class String
  def singularize
    self.chomp('s')
  end

  def constantize
    Module.const_get(self)
  end

  def pluralize
    self + 's'
  end

  def truncate(length)
    (self.size > length) ? self[0..length-1] + "..." : self
  end
end
