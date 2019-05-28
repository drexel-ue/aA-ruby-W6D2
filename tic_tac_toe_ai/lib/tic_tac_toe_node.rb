require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos if prev_move_pos != nil
  end

  def losing_node?(evaluator)
    return @board.winner != evaluator if @board.over?
    children = self.children
    if @next_mover_mark == evaluator
      children.all? { |child| child.losing_node?(evaluator) }
    else
      children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    return @board.winner == evaluator if @board.over?
    children = self.children
    if @next_mover_mark == evaluator
      children.any? { |child| child.winning_node?(evaluator) }
    else
      children.all? { |child| child.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    moves = []
    mark = @next_mover_mark == :x ? :o : :x
    (0..2).each do |index1|
      (0..2).each do |index2|
        pos = [index1, index2]
        if @board.empty?(pos)
          dupe = @board.dup 
          dupe[pos] = @next_mover_mark
          moves << TicTacToeNode.new(dupe, mark, pos)
        end
      end
    end
    moves
  end
end
