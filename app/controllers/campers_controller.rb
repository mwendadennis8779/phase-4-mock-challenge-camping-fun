class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :bad_id

    def index
        render json: Camper.all 
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper, include: :activities
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created

    end
    
    private
    
    def camper_params
        params.permit(:name, :age)
    end

    def render_unprocessable_entity_response(invalid)
        render json: {error: ["validation errors"]}, status: :unprocessable_entity
    end

    def bad_id
        render json: {error: "Camper not found"}, status: :not_found
    end
end
