require "pathname"
require "gemlist/version"
require "gemlist/options"

class Gemlist
  def initialize(path, options = {})
    @path    = Pathname.new(path)
    @options = Options.new(options)
  end

  def gems
    []
  end

  private

  def groups
    ([:default] + options.included_groups - options.excluded_groups).uniq
  end

  attr_reader :path, :options
end
