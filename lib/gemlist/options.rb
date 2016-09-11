require "gemlist/group_conflict"

class Gemlist
  class Options
    def initialize(options = {})
      @options = options

      validate!
    end

    def excluded_groups
      options.fetch(:without) { [] }
    end

    def included_groups
      options.fetch(:with) { [] }
    end

    private

    attr_reader :options

    def validate!
      assert_groups_dont_conflict!
    end

    def assert_groups_dont_conflict!
      intersection = excluded_groups & included_groups

      raise GroupConflict.new(*intersection) unless intersection.empty?
    end
  end
end
