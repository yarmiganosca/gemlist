require 'bundler'
require 'gemlist/spec_node'

class Gemlist
  class SpecTree < SpecNode
    def initialize(lockfile)
      lockfile_parser = Bundler::LockfileParser.new(lockfile.read)

      super("root", lockfile_parser)

      specs_to_place = lockfile_parser.specs.to_set

      # start with the top-level declared dependencies
      lockfile_parser.dependencies.each do |dependency|
        spec_for_dependency = specs_to_place.find { |spec| spec.name == dependency.name }

        self << SpecNode.new(spec_for_dependency.name, spec_for_dependency)

        specs_to_place.delete(spec_for_dependency)
      end

      until specs_to_place.empty?
        specs_to_place.each do |spec|
          # we find all the specs that are parent to this one, so that we can
          # just remove entire top-level branches when it comes time to exclude
          # groups
          parent_nodes = select do |node|
            node.content.dependencies.any? do |dependency|
              dependency.name == spec.name
            end
          end

          parent_nodes.each do |node|
            node << SpecNode.new(spec.name, spec)
          end

          specs_to_place.delete(spec) if parent_nodes.any?
        end
      end
    end
  end
end
