class CreatureTrainer
  def initialize(creature, skill)
    @creature = creature
    @skill = skill
    @errors = []
  end

  ##
  # The list of errors that occurred.
  def errors
		@errors.join(', ')
  end

  def train
    unless creature_is_trainable?
       @errors << "Cannot train a creature that is not ready"
    end
  end

  def creature_is_trainable?
    @creature.state == "ready"
  end
end
