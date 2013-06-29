require 'spec_helper'

describe 'Training creatures' do
  it 'requires there to be a creature given' do
    post '/training'
    response.status.should == 422
    response.body.should == {error: 'A creature is required for training'}.to_json
  end

  it 'requires the creature to be in a ready state' do
    creature = FactoryGirl.create(:creature_training)
    post '/training', creature_id: creature.id, skill: "hunting"
    response.status.should == 422
    response.body.should == {error: 'Cannot train a creature that is not ready'}.to_json
  end
end

