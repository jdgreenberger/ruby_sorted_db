require "rspec"
require './app/record_translation'

describe RecordTranslation do

  describe 'deserialize_line' do

    describe 'invalid input' do

    end

    describe 'valid input' do
      let(:expected_output) { { 
        last_name: 'Honey', 
        first_name: 'Jane', 
        favorite_color: 'Green', 
        dob: '10/22/1992'
      } }
      [
        { context: 'comma separated line without trailing spaces', input: 'Honey,Jane,Green,10/22/1992' },
        { context: 'comma separated line with trailing spaces', input: 'Honey  , Jane ,Green, 10/22/1992  ' },
        { context: 'pipe separated line without trailing spaces', input: 'Honey,Jane,Green,10/22/1992' },
        { context: 'pipe separated line with trailing spaces', input: 'Honey  | Jane |Green| 10/22/1992  ' },
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
    # context 'input not include a valid character to deserialize' do

    #   it 'throws an error' do

    #   end
    #   # expect(RecordTranslation.deserialize_line('honey.jane.green.10/12/1992')).to.throw 'Invalid input'
    # end

    # context 'input contains too many fields' do

    # end

    # context 'input contains too few fields' do

    # end

# module RecordTranslation
#   def self.deserialize_line(line)
#     if (!line.include?('|') or !line.include?(',')) {
#       throw 'Invalid Input'
#     }
#     split_char = line.include?('|') ? '|' : ','
#     words = line.gsub(/\s+/, "").split(split_char)
#     # add input handling
#     { last_name: words[0] , first_name: words[1], favorite_color: words[2], dob: words[3] }
#   end
# end
