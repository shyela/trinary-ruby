class TrinaryTree
  attr_reader :root

  def initialize
    @root = nil
  end

  def insert(val)
    if @root.nil?
      @root = TrinaryNode.new val
    else
      @root.insert val
    end
  end

  def delete(val)
    unless @root.nil?
      @root.delete val, self
    end
  end

  def replace( node, replacement )
    if @root == node
      @root = replacement
    end
  end

end


class TrinaryNode
  attr_accessor :val, :left, :middle, :right

  def initialize(val)
    @val = val
  end

  def insert(val)
    if val < @val
      insert_left val
    elsif val > @val
      insert_right val
    else
      insert_middle val
    end
  end

  def delete(val, parent)
    if val < @val
      delete_left val
    elsif val > @val
      delete_right val
    else
      delete_self parent
    end
  end

  def replace( node, replacement )
    if node == @right
      @right = replacement
    elsif node == @left
      @left = replacement
    end
  end

  def find_smallest_child
    if @left.nil?
      return self
    else
      return @left.find_smallest_child
    end
  end

  private

  def insert_right(val)
    if @right.nil?
      @right = TrinaryNode.new val
    else
      @right.insert val
    end
  end

  def insert_left(val)
    if @left.nil?
      @left = TrinaryNode.new val
    else
      @left.insert val
    end
  end

  def insert_middle(val)
    if @middle.nil?
      @middle = TrinaryNode.new val
    else
      @middle.insert val
    end
  end

  def delete_right(val)
    unless @right.nil?
      @right.delete val, self
    end
  end

  def delete_left(val)
    unless @left.nil?
      @left.delete val, self
    end
  end

  def delete_self(parent)
    if @middle.nil?

      replacement = nil

      # try the right first
      unless @right.nil?
        # look for the smallest of the larger nodes
        replacement = @right.find_smallest_child

        unless replacement.nil?
          # remove the node that's being moved up
          @right.delete replacement.val, self

          # configure it to take its rightful place!
          replacement.right = @right
          replacement.left = @left
        end
      end

      # then the left, if we have to
      if replacement.nil?
        unless @left.nil?
          # just move the left node up
          replacement = @left
        end
      end

      # put it in its new place
      parent.replace self, replacement
    else
      @middle = @middle.middle
    end
  end
end
