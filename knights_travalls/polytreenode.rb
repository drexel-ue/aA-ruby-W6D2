class PolyTreeNode

    attr_accessor :value, :children
    attr_reader :parent

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(node = nil)
        @parent.children.delete(self) if @parent != nil
        @parent = node 
        node.children << self if node != nil && !node.children.include?(self)
    end

    def add_child(child)
        child.parent = self
        @children << child if !@children.include?(child)
    end

    def remove_child(child)
        child.parent = nil
        raise 'NOT A CHILD' if !@children.include?(child)
    end

    def dfs(target_value)
        return self if @value == target_value
        @children.each do |child|
            result = child.dfs(target_value) 
            return result if result != nil
        end
        nil
    end

    def bfs(target_value)
        arr = []
        queue = [self]

        until queue.empty?
            node = queue.shift
            arr << node.value if node.dfs(target_value) != nil
            if node.value == target_value
                return arr
            else
                node.children.each { |child| queue << child }
            end
        end
    end

end

