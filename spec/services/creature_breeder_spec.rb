require 'fast_spec_helper'
require 'services/creature_breeder'

describe CreatureBreeder do
  describe '#breed' do
    it "returns nil if the parent creatures are not compatable"
    it "returns the new creature that was created from the parents"
  end

  describe '#errors' do
    it "returns the errors that have been set on the breeder"
    it "returns an empty list if there are no errors on the breeder"
  end

  describe 'correct_parents_given?' do
    it "returns true if the parents are correct"
    it "returns false if two creatures are not given"
    it "returns false if the creatures given are not different"
    it "sets errors onto the breeder as needed"
  end
  
  describe 'parents_are_compatable?' do
    it "returns true if the mother and the father are compatable"
    it "returns false if the creatures are not of different genders"
    it "returns false if either the mother or the father are too young to breed"
    it "returns false if either the mother or the father are too old to breed"
    it "returns false if the mother and the father are directly related"
    it "sets all the relavent errors onto the breeder"
  end

  describe 'create_new_creature_from_parents' do

  end
end
