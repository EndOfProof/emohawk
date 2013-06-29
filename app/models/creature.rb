class Creature < ActiveRecord::Base
	attr_accessible :name
	attr_accessible :age
	as_enum :gender, :female =>1, :male => 0

#has_one :father, :class_name => "Creature", :foreign_key => 'father_id'
#has_one :mother, :class_name => "Creature", :foreign_key => 'mother_id'
#has_many :children, :class_name => "Creature"

	belongs_to :father, :class_name => 'Creature'
	belongs_to :mother, :class_name => 'Creature'
	has_many :children_of_father, :class_name => 'Creature', :foreign_key => 'father_id'
	has_many :children_of_mother, :class_name => 'Creature', :foreign_key => 'mother_id'

	def children
		return children_of_mother if gender == :female
		return children_of_father if gender == :male
	end

  state_machine :state, :initial => :ready do
    event :begin_training do
      transition ready: :training
    end

    event :finish_training do
      transition training: :ready
    end

    event :begin_breeding do
      transition ready: :breeding
    end

    event :finish_breeding do
      transition breeding: :ready
    end

    event :become_pregnant do
      transition breeding: :pregnant
    end

    event :birth do
      transition pregnant: :ready
    end

    state :ready do

    end

    state :training do

    end

    state :breeding do

    end

    state :pregnant do
      validate do |creature|
        errors.add(:base, 'Only female creatures can become pregnant') unless creature.female?
      end
    end
  end
end
