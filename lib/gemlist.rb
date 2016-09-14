require "pathname"
require "gemlist/version"
require 'gemlist/group_conflict'
require "gemlist/spec_tree"

class Gemlist
  def initialize(path, options = {})
    @path    = Pathname.new(path)
    @options = options
  end

  def gems
    specs.each.with_index.with_object([]) do |(spec, index), uniquified_specs|
      last_occurrence_of_spec = specs.rindex(spec) == index

      uniquified_specs << spec if last_occurrence_of_spec
    end
  end

  private

  def specs
    spec_tree = SpecTree.new(lockfile)

    spec_tree
      .depth_first_children_first
      .reject(&:is_root?)
      .select { |node| node.descends_from?(*top_level_dependencies) }
      .map(&:content)
  end

  def top_level_dependencies
    bundle_definition
      .dependencies
      .select { |dependency| (dependency.groups & groups).any? }
  end

  def bundle_definition
    return @bundle_definition unless @bundle_definition.nil?

    builder = Bundler::Dsl.new
    builder.eval_gemfile(path/"Gemfile")

    @bundle_definition = builder.to_definition(lockfile, {})
  end

  def lockfile
    @lockfile ||= path/"Gemfile.lock"
  end

  def groups
    excluded_groups = options.fetch(:without) { [] }
    included_groups = options.fetch(:with) { [] }

    intersection    = excluded_groups & included_groups

    raise GroupConflict.new(*intersection) if intersection.any?

    bundle_definition.groups + included_groups - excluded_groups
  end

  attr_reader :path, :options
end
