require 'tree'

class Gemlist
  class SpecNode < Tree::TreeNode
    def total_dependency_count
      size - 1
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
      [self, *parentage].reverse.reject(&:is_root?)
    end

    def descends_from?(*dependencies)
      !is_root? &&
        dependencies.map(&:name).include?(lineage.first.name)
    end
  end
end
