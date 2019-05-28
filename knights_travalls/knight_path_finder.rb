#require 'byebug'
require_relative 'polytreenode'

class KnightPathFinder

    MOVES = [
        [-2,-1], 
        [-2, 1], 
        [-1,-2], 
        [-1, 2],
        [1, -2], 
        [1,  2], 
        [2, -1], 
        [2,  1]
    ]


    def self.valid_moves(pos)
        valid_moves = []

        x, y = pos
        MOVES.each do |(mx, my)|
            new_pos = [x + mx, y + my]
            
            if new_pos.all? { |coordinate| coordinate.between?(0,7) }
                valid_moves << new_pos
            end
        end
        valid_moves
    end

    attr_reader :considered_positions

    def initialize(position)
       # debugger
        @position = position
        @considered_positions = [position]
        @root_node = PolyTreeNode.new(position)
        build_move_tree
    end

    def new_move_positions(position)
        KnightPathFinder.valid_moves(position)
        .reject { |pos| @considered_positions.include?(pos) }
        .each { |pos| @considered_positions << pos }
    end

    def build_move_tree
        queue = [@root_node]

        until queue.empty?
            current_node = queue.shift
            moves = new_move_positions(current_node.value)
            moves.each do |move| 
                new_node = PolyTreeNode.new(move)
                current_node.add_child(new_node)
                queue << new_node
            end
        end

        # moves = self.new_move_positions(@position) # pos = [0,0] => [[1,2], [2,1]]

        # until moves.empty?
        #     move = moves.shift
        #     memo = PolyTreeNode.new(move)
        #     root_node.add_child(memo)
        #     KnightPathFinder.valid_moves(memo.value).each { |potential| moves << potential if !@considered_positions.include?(potential)}
        # end
     
    end

end


p tom = KnightPathFinder.new([0,0])
p tom.considered_positions.uniq.count == tom.considered_positions.count