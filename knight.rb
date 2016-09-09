require_relative "poly_tree"

class KnightPathFinder
  def initialize(pos)
    @root = PolyTreeNode.new(pos)
    @visited_postions = [pos]
    @delta = [[1,2],[1,-2],[-1,2],[-1,-2],[2,1],[2,-1],[-2,1],[-2,-1]]
    @tree = []
  end

  def root
    @root
  end

  def new_move_positions(pos)
    possible_moves = []
     @delta.each do |delta|
       x,y = pos[0] + delta[0] , pos[1] + delta[1]
        possible_moves << [x,y] if valid_moves?([x,y]) && !@visited_postions.include?([x,y])
      end
      @visited_postions += possible_moves
      possible_moves

  end

  def valid_moves?(pos)
    pos.all? {|el| el >= 0 && el <= 8}
  end

  def build_move_tree
    curr_node = @root
    queue = [curr_node]
    until queue.empty?
      curr_node = queue.shift
      curr_possible_moves = new_move_positions(curr_node.value)
      curr_possible_moves.each do |pos|
        curr_move = PolyTreeNode.new(pos)
        curr_move.parent = curr_node
        queue << curr_move
      end

    end
  end

  def find_path(target_pos)
    target_node = @root.dfs(target_pos)
    trace_path_back(target_node) unless target_node.nil?
  end

  def trace_path_back(target_node)
    path_arr = [target_node.value]
    until target_node.parent.nil?
      #p "current tar: #{target_node.value}, and its parent is #{target_node.parent.value}"
      path_arr << target_node.parent.value
      target_node = target_node.parent
      #p "New tar: #{target_node.value}, and its parent is #{target_node.parent.value}"
    end
    path_arr.reverse
  end
end
