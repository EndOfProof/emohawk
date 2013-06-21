require 'spec_helper'

describe 'Breeding creatures' do
  it 'requires there to be two creatures' do
    post '/', id: 1
    response.status.should == 422
    response.body.should == {error: 'Two creatures required for breeding'}.to_json
  end

  it 'requires the creatures given to be different' do
    post '/', creature1_id: 1, creature2_id: 1
    response.status.should == 422
    response.body.should == {error: 'Cannot breed a creature with itself'}
  end

  it 'requires the creatures to be different genders' do
    creature1 = FactoryGirl.create(:creature_female)
    creature2 = FactoryGirl.create(:creature_female)

    post '/', creature1_id: creature1.id, creature2_id: creature2.id
    response.status.should == 422
    response.body.should == {error: 'Cannot breed creatures of the same gender'}
  end

  it 'requires the creatures to be compatible' do
    creature1 = FactoryGirl.create(:creature_female_flame)
    creature2 = FactoryGirl.create(:creature_male_water)

    post '/', creature1_id: creature1.id, creature2_id: creature2.id
    response.status.should == 422
    response.body.should == {error: 'Cannot breed creatures with incompatable types'}
  end

  it 'returns the details of the new creature that has been bred' do
    creature1 = FactoryGirl.create(:creature_female_flame)
    creature2 = FactoryGirl.create(:creature_male_flame)

    post '/', creature1_id: creature1.id, creature2_id: creature2.id
    response.status.should == 200
    JSON.parse(response.body).should have_key('creature_id')
  end
end
