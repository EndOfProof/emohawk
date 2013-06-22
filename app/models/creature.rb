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
end
