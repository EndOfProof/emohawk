require 'spec_helper'

describe 'Breeding creatures' do
  it 'requires there to be two creatures' do
    post '/', id: 1
    response.status.should == 422
    response.body.should == {error: 'Two creatures required for breeding'}.to_json
  end

  it 'requires the creatures given to be different' do
    creature1 = FactoryGirl.create(:creature_female)
    post '/', creature1_id: 1, creature2_id: 1
    response.status.should == 422
    response.body.should == {error: 'Cannot breed a creature with itself'}.to_json
  end

  it 'requires the creatures to be different genders' do
    creature1 = FactoryGirl.create(:creature_female)
    creature2 = FactoryGirl.create(:creature_female)

    post '/', creature1_id: creature1.id, creature2_id: creature2.id
    response.status.should == 422
    response.body.should == {error: 'Cannot breed creatures of the same gender'}.to_json
  end

  it 'requires the creatures to be compatible' do
    creature1 = FactoryGirl.create(:creature_female_flame)
    creature2 = FactoryGirl.create(:creature_male_water)

    post '/', creature1_id: creature1.id, creature2_id: creature2.id
    response.status.should == 422
    response.body.should == {error: 'Cannot breed creatures with incompatable types'}.to_json
  end

  it 'returns the details of the new creature that has been bred' do
    creature1 = FactoryGirl.create(:creature_female)
    creature2 = FactoryGirl.create(:creature_male)

    post '/', creature1_id: creature1.id, creature2_id: creature2.id
    response.status.should == 200
    JSON.parse(response.body).should have_key('creature')
  end

	it 'requires the creatures to be old enough to breed' do
		creature1 = FactoryGirl.create(:creature_too_young_to_breed, gender: :male)
		creature2 = FactoryGirl.create(:creature, gender: :female)

		post '/', creature1_id: creature1.id, creature2_id: creature2.id
		response.status.should == 422
    response.body.should == {error: 'Creatures must be old enough to breed'}.to_json
	end

	it 'requires the creatures to be young enough to breed' do
		creature1 = FactoryGirl.create(:creature_too_old_to_breed, gender: :male)
		creature2 = FactoryGirl.create(:creature, gender: :female)

		post '/', creature1_id: creature1.id, creature2_id: creature2.id
		response.status.should == 422
    response.body.should == {error: 'Creatures must be young enough to breed'}.to_json
	end

	it 'requires the creatures not be related to breed' do
		creature1 = FactoryGirl.create(:creature_male)
		creature2 = FactoryGirl.create(:creature_female, father: creature1)

		post '/', creature1_id: creature1.id, creature2_id: creature2.id
		response.status.should == 422
    response.body.should == {error: 'Creatures must not be related'}.to_json
	end
end
