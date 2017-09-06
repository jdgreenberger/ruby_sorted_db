# frozen_string_literal: true

require 'rspec'
require './app/database/cache_service'

Key = Struct.new(:attribute, :order)

describe CacheService do
  let(:cache_service) { CacheService.new([]) }
  let(:seed_records) do
    [
      { last_name: 'Honey', first_name: 'Jane', favorite_color: 'Green', dob: '10/22/1992' },
      { last_name: 'Deer', first_name: 'John', favorite_color: 'Blue', dob: '10/22/1999' },
      { last_name: 'Grove', first_name: 'Ashley', favorite_color: 'Blue', dob: '10/22/1999' }
    ]
  end

  describe 'add_index' do
    context 'one attribute' do
      before do
        keys = [Key.new(:favorite_color, 'desc')]
        seed_records.each { |record| cache_service.add(record) }
        cache_service.add_index(:index1, keys)
      end

      it 'creates an ordered binary search tree on the index' do
        expect(cache_service.retrieve_indexed_records(:index1)).to eql(
          [seed_records[0], seed_records[2], seed_records[1]]
        )
      end
    end

    context 'multiple attributes' do
      before do
        keys = [
          Key.new(:favorite_color, 'asc'),
          Key.new(:first_name, 'asc')
        ]
        seed_records.each { |record| cache_service.add(record) }
        cache_service.add_index(:index1, keys)
      end

      it 'creates an ordered binary search tree on the index' do
        expect(cache_service.retrieve_indexed_records(:index1)).to eql(
          [seed_records[2], seed_records[1], seed_records[0]]
        )
      end
    end
  end
end
