require 'byebug'
class PolyTreeNode

  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def add_child(child_name)
    child_name.parent = self
  end

  def remove_child(child_name)
    child_name.parent = nil
  end
  def parent=(prnt)
    # byebug
    if prnt.nil?
      @parent.children.delete(self)
      @parent = nil
      return self
    end

    unless self.parent.nil?
      @parent.children.delete(self)
      @parent = prnt
      @parent.children.push(self)
    else
      @parent = prnt
      @parent.children.push(self)
    end
  end

  def dfs(target_value)

    return self if self.value == target_value

    self.children.each do |el|
      result = el.dfs(target_value)
      return result if result
    end

    nil
  end

  # def dfs_helper(target, node)
  #   return self if node.value == target
  #
  #   temp_child = node.children.map {|el| el.dup}
  #   if temp_child.empty?
  #     return nil
  #   end
  #   self.temp_child.each do |el|
  #     dfs_helper(target_value, el.children.shift)
  #   end
  #
  # end

  def bfs(target_value)
    return self if self.value == target_value

    visit_queue = self.children

    until visit_queue.empty?
      if visit_queue.first.value == target_value
        return visit_queue.first
      else
        visit_queue += visit_queue.first.children
        visit_queue.shift
      end
    end

    nil
  end


end
