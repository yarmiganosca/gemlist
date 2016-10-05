class Gemlist
  class SpecNode
    include Enumerable

    attr_reader :name, :content, :children
    attr_accessor :parent

    def initialize(name, content)
      @name     = name
      @content  = content
      @children = []
      @parent   = nil
    end

    def <<(node)
      @children << node
      node.parent = self
      node
    end

    def each(&block)
      return to_enum unless block_given?

      unvisited = [self]

      until unvisited.empty?
        current = unvisited.shift

        if current
          yield current

          unvisited.unshift(*current.children)
        end
      end

      return self if block_given?
    end
    
    def total_dependency_count
      size - 1
    end

    def size
      to_a.size
    end

    def depth_first_children_first
      sorted_children = children.sort_by(&:total_dependency_count)
      parent          = self

      Enumerator.new do |yielder|
        sorted_children.each do |child|
          child.depth_first_children_first.each do |node|
            yielder << node
          end
        end

        yielder << parent
      end
    end

    def lineage
      [self, *parentage].reverse.reject(&:root?)
    end

    def descends_from?(*dependencies)
      !root? &&
        dependencies.map(&:name).include?(lineage.first.name)
    end

    def parentage
      return [] if root?

      [parent] + parent.parentage
    end

    def root?
      parent.nil?
    end
  end
end
