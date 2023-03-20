class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def create
        camper = Camper.find(params[:camper_id])
        activity = Activity.find(params[:activity_id])

        camper.present? && activity.present?
        sign = camper.signups.create!(signup_params)
        sign.activity = activity

        render json: activity.slice(:id, :name, :difficulty), status: :created
    end

    private
    def signup_params
        params.permit(:camper_id, :activity_id, :time)
    end

    def render_unprocessable_entity_response(invalid)
        render json: {error: ["validation errors"]}, status: :unprocessable_entity
    end
end
