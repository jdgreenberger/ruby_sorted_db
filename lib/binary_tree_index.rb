class BTreeIndex
  class Node
    attr_reader :left, :right, :content

    def initialize( content )
      @content = content
      @left = nil
      @right = nil
    end

    def insert( content, keys )
      keys.each do |key|
        if content[key.attribute] == @content[key.attribute] # attribute is equal, try the next 
          next
        end
        nodeIsLess = content[key.attribute] < @content[key.attribute] 
        if (nodeIsLess && key.order == 'asc') || (!nodeIsLess && key.order == 'desc')
          @left.nil? ? @left = Node.new( content ) : @left.insert( content, keys )
        elsif (nodeIsLess && key.order == 'desc') || (!nodeIsLess && key.order == 'asc')
          @right.nil? ? @right = Node.new( content ) : @right.insert( content, keys )
        end
        return
      end
      # all attribute keys are equal, arbitrarily pick left child
      @left.nil? ? @left = Node.new( content ) : @left.insert( content, keys )
    end
  end
 
  def initialize( keys )
    @root = nil
    @keys = keys
  end
 
  def insert( content )
    if @root.nil?
      @root = Node.new( content )
    else
      @root.insert( content, @keys )
    end
  end

  def in_order(node=@root, &block)
    return if node.nil?
    in_order(node.left, &block)
    yield node
    in_order(node.right, &block)
  end

  def post_order(node=@root, &block)
    return if node.nil?
    post_order(node.right, &block)
    yield node
    post_order(node.left, &block)
  end
end
