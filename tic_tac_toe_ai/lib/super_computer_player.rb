require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    children = node.children
    win_possible = children.any? { |child| child.winning_node?(mark) }
    tie_possible = children.any? { |child| !child.losing_node?(mark) }
    if win_possible
      children.each { |child| return child.prev_move_pos if child.winning_node?(mark) }
    elsif tie_possible
      children.each { |child| return child.prev_move_pos if !child.losing_node?(mark) }
    else
      raise 'what the eff'
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
