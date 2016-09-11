class Gemlist
  class GroupConflict < StandardError
    def initialize(*group_names)
      super "The groups #{group_names.join(', ')} were both excluded from and included in the gemlist."
    end
  end
end
