class Gemlist
  class GroupConflict < StandardError
    def initialize(*group_names)
      super "The groups #{group_names} were both excluded from and included in the gemlist."
    end
  end
end
