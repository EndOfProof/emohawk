class CreaturesController < ApplicationController
  def index
		if params[:creature1_id].nil? || params[:creature2_id].nil?
			render :json => {error: 'Two creatures required for breeding'}.to_json, :status => 422 and return
		end

		cb = CreatureBreeder.new Creature.find(params[:creature1_id]), Creature.find(params[:creature2_id])
		child = cb.breed

		if child
			render :json => child
		else
			render :json => {error: cb.errors}.to_json, :status => 422 and return
		end
  end
end
