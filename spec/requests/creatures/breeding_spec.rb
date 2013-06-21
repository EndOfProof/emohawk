require 'spec_helper'

describe 'Breeding creatures' do
  it 'requires there to be two creatures' do
    post '/', id: 1
    response.status.should == 422
  end
end
