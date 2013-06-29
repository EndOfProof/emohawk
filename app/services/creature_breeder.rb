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
		@errors.join(', ')
  end

  ##
  # Checks if the correct entities have been given. Errors are set on the breeder as needed.
  #
  #
  # @return [Boolean] true if the entities are correct; false otherwise
  def correct_parents_given?
		if @mother.instance_of?(Creature) && @father.instance_of?(Creature)	
			if @mother == @father
				@errors.push "Cannot breed a creature with itself"
			else
				if @mother.gender == :male
					tmp = @father
					@father = @mother
					@mother = tmp
				end
			end
		else
			@errors.push "Two creatures are required to breed"
		end
	
		@errors.empty? ? true : false
  end

  ##
  # Checks if the parents are compatible. All relevant errors are set on the breeder
  # as needed.
  #
  # @return [Boolean] true if the parents are compatable; false otherwise.
  def parents_are_compatable?
    if @mother.gender == @father.gender
			@errors << "Cannot breed creatures of the same gender"
		end

		if @mother.age < 7 || @father.age < 7
			@errors << "Creatures must be old enough to breed"
		end

		if @mother.age > 30 || @father.age > 30
			@errors << "Creatures must be young enough to breed"
		end

		if @mother.father == @father || @father.mother == @mother
			@errors << "Creatures must not be related"
		end

		if @mother.father && @mother.father == @father.father
			@errors << "Creatures must not be related"
		end

		if @mother.mother && @mother.mother == @father.mother
			@errors << "Creatures must not be related"
		end
		
		@errors.empty? ? true : false
  end

  ##
  # Create a new creature from the parents.
  #
  # @return [Creature] the new creature
  def create_new_creature_from_parents
		child = Creature.new
		child.mother = @mother
		child.father = @father
		child.age = 0
		child.gender = [:male,:female].sample
		child.save
		child
  end
end
