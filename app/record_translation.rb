# frozen_string_literal: true

module RecordTranslation
  def self.deserialize_line(line)
    throw 'Invalid Input' if !line.include?('|') && !line.include?(',')
    split_char = line.include?('|') ? '|' : ','
    words = line.gsub(/\s+/, '').split(split_char)
    { last_name: words[0], first_name: words[1], favorite_color: words[2], dob: words[3] }
  end
end
