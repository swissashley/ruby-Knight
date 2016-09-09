require 'byebug'

class PolyTreeNode

  def initialize(val)
    @value = val
    @parent = nil
    @children = []

  end

  def parent
    # a PolyTreeNode object for the parent.
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(parent)
    @parent.children.delete(self) unless @parent == nil

    @parent = parent
    parent.children << self unless parent == nil
  end

  def add_child(child_node)
    child_node.parent= self
    # @children << child_node unless @children.include?(child_node)

  end

  def remove_child(child)
    raise Exception.new("not a child") unless @children.include? (child)
    child.parent=nil
  end

  def dfs(target_value)
    # byebug
    return self if target_value == @value
    # return nil if @childen.empty?
    @children.each do |child|
      result = child.dfs(target_value)
      return result unless result.nil?
    end
    nil
  end

  def bfs(target_value)
    return self if target_value == value
    queue = []
    queue += @children
    until queue.empty?
      first_child = queue.shift
      return first_child if first_child.value == target_value
      queue += first_child.children
    end
    nil
  end
end
