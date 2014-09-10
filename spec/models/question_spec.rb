require 'spec_helper'

describe Card do

	describe '#initialize' do 
		it 'makes a new card instance with said properties' do
			Card.create(set: "Revised")
			Card.all.count.should eq 1
			Card.all.first.set.should eq "Revised"
		end
	end
end