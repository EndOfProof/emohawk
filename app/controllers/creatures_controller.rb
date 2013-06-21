class CreaturesController < ApplicationController
  def index
    unless params[:creature1_id] && params[:creature2_id]
      return render json: {error: "Two creatures required"}, status: :unprocessable_entity
    end
    
    
    
    debugger
    puts 'adf'

  end
end
