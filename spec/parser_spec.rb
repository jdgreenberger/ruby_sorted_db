require "rspec"
require "rspec/its"
require_relative '../lib/parser'

describe Parser do
  context "next" do
    it 'does something' do
    	expect(true).to eq(true)
    end
  end
end


# Input

# A record consists of the following fields: last name, first name, date of birth and favorite color. 
# The input comes in two formats:

# The pipe-delimited file lists each record as follows: 
# LastName | FirstName | FavoriteColor | DateOfBirth
# The comma-delimited file looks like this: 
# LastName, FirstName, FavoriteColor, DateOfBirth
# Output

# Your system should allow the presentation of the data in 3 formats:

# Output 1 – sorted by favorite color descending, then by last name ascending.
# Output 2 – sorted by birth date, ascending.
# Output 3 – sorted by last name, descending.
