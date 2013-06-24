##
# This service class is intended to provide a method for breeding creatures.
class CreatureBreeder
  def initialize(mother, father)
    @mother = mother
    @father = father
    @errors = []
  end

  ##
  # Breed the mother and father, if possible. This checks that the parents are
  # correct and compatable, and reports any errors that occurred.
  #
  # @return [Creature, nil] the new creature, or nil
  def breed
    if correct_parents_given? && parents_are_compatable?
      create_new_creature_from_parents
    else
      nil
    end
  end

  ##
  # The list of errors that occurred.
  def errors

  end

  ##
  # Checks if the correct entities have been given. Errors are set on the breeder as needed.
  #
  #
  # @return [Boolean] true if the entities are correct; false otherwise
  def correct_parents_given?
    
  end

  ##
  # Checks if the parents are compatible. All relevant errors are set on the breeder
  # as needed.
  #
  # @return [Boolean] true if the parents are compatable; false otherwise.
  def parents_are_compatable?
    
  end

  ##
  # Create a new creature from the parents.
  #
  # @return [Creature] the new creature
  def create_new_creature_from_parents

  end
end
