# frozen_string_literal: true

require_relative './binary_tree_index'

class CacheService
  def initialize(cache)
    @indexes = {}
    @cache = cache
  end

  def add(record)
    @cache.push record
  end

  def add_index(name, keys)
    btree = BTreeIndex.new(keys)
    @cache.each { |record| btree.insert(record) }
    @indexes[name] = btree
  end

  def retrieve_indexed_records(name)
    records = []
    @indexes[name].in_order { |node| records.push(node.content) } # can I use some kind of map here?
    records
  end
end
