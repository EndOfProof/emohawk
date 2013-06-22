class CreaturesController < ApplicationController
  def index
		if params[:creature1_id].nil? || params[:creature2_id].nil?
			render :json => {error: 'Two creatures required for breeding'}.to_json, :status => 422 and return
		end
		if params[:creature1_id]==params[:creature2_id]
			render :json => {error: 'Cannot breed a creature with itself'}.to_json, :status => 422 and return 
		end

		mother = Creature.find(params[:creature1_id])
		if(mother.gender == :female)
			father = Creature.find(params[:creature2_id])
		else
			mother = Creature.find(params[:creature2_id])
			father = Creature.find(params[:creature1_id])
		end

		if mother.nil? || father.nil?
			render :json => {error: 'Two creatures required for breeding'}.to_json, :status => 422 and return
		end

		if mother.age < 6 || father.age < 6
			render :json => {error: 'Creatures must be old enough to breed'}.to_json, :status => 422 and return
		elsif mother.age > 30 || father.age > 30
			render :json => {error: 'Creatures must be young enough to breed'}.to_json, :status => 422 and return
		end

		if mother.gender == father.gender
			render :json => {error: 'Cannot breed creatures of the same gender'}.to_json, :status => 422 and return
		end

		#if mother.children.find(father.id) || father.children.find(mother.id)
		if mother.father == father || father.mother == mother
			render :json => {error: 'Creatures must not be related'}.to_json, :status => 422 and return
		end

		if mother.father && mother.father == father.father
			render :json => {error: 'Creatures must not be related'}.to_json, :status => 422 and return
		end
		if mother.mother && mother.mother == father.mother
			render :json => {error: 'Creatures must not be related'}.to_json, :status => 422 and return
		end

		child = Creature.new
		child.mother = mother
		child.father = father
		child.age = 0
		child.gender = [:male,:female].sample
		child.save
		render :json => child
  end
end
