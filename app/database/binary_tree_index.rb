# frozen_string_literal: true

class BTreeIndex
  class Node
    attr_reader :left, :right, :content

    def initialize(content)
      @content = content
      @left = nil
      @right = nil
    end

    def find_child_direction(content, keys)
      direction = nil
      keys.any? do |key|
        next if content[key.attribute] == @content[key.attribute] # attribute is equal, try the next
        node_is_less = content[key.attribute] < @content[key.attribute]
        direction = case key.order
                    when 'asc' then node_is_less ? 'left' : 'right'
                    when 'desc' then node_is_less ? 'right' : 'left'
                    end
      end
      direction || 'left' # all attribute keys are equal, arbitrarily pick left child
    end

    def insert(content, keys)
      direction = find_child_direction(content, keys)
      if direction == 'left'
        @left.nil? ? @left = Node.new(content) : @left.insert(content, keys)
      else
        @right.nil? ? @right = Node.new(content) : @right.insert(content, keys)
      end
    end
  end

  def initialize(keys)
    @root = nil
    @keys = keys
  end

  def insert(content)
    if @root.nil?
      @root = Node.new(content)
    else
      @root.insert(content, @keys)
    end
  end

  def in_order(node = @root, &block)
    return if node.nil?
    in_order(node.left, &block)
    yield node
    in_order(node.right, &block)
  end
end
