class CreaturesController < ApplicationController
  def index
		if params[:creature1_id].nil? || params[:creature2_id].nil?
			return render json: {error: 'Two creatures required for breeding'}.to_json, status: 422
		end

		cb = CreatureBreeder.new(Creature.find(params[:creature1_id]), Creature.find(params[:creature2_id]))
		child = cb.breed

		if child
			render json: child
		else
			render json: {error: cb.errors}.to_json, status: 422
		end
  end

  def training
    if params[:creature_id].nil?
      return render json: {error: 'A creature is required for training'}.to_json, status: 422
    end
    if params[:skill].nil?
      return render json: {error: 'A skill is required for training'}.to_json, status: 422
    end

    trainer = CreatureTrainer.new(Creature.find(params[:creature_id]), params[:skill])
    result = trainer.train

    if result
      render json: "Training"
    else
      render json: {error: trainer.errors}.to_json, status: 422
    end
  end
end
