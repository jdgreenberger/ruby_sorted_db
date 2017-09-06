# frozen_string_literal: true

require 'rspec'
require './app/record_translation'

describe RecordTranslation do
  describe 'deserialize_line' do
    describe 'invalid input' do
    end

    describe 'valid input' do
      let(:expected_output) do
        {
          last_name: 'Honey',
          first_name: 'Jane',
          favorite_color: 'Green',
          dob: '10/22/1992'
        }
      end
      [
        {
          context: 'comma separated line without trailing spaces',
          input: 'Honey,Jane,Green,10/22/1992'
        },
        {
          context: 'comma separated line with trailing spaces',
          input: 'Honey  , Jane ,Green, 10/22/1992  '
        },
        {
          context: 'pipe separated line without trailing spaces',
          input: 'Honey,Jane,Green,10/22/1992'
        },
        {
          context: 'pipe separated line with trailing spaces',
          input: 'Honey  | Jane |Green| 10/22/1992  '
        }
      ].each do |test|
        context test[:context] do
          it 'returns a deserialized object' do
            expect(RecordTranslation.deserialize_line(test[:input])).to eql(expected_output)
          end
        end
      end
    end
  end
end
