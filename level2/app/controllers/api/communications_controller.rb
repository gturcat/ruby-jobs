class Api::CommunicationsController < ApplicationController

  def create
    practitioner = Practitioner.where(first_name: communication_params[:first_name], last_name: communication_params[:last_name]).first

    communication = Communication.new(practitioner_id: practitioner.id, sent_at: communication_params[:sent_at])

    communication.save

    render json: communication.to_json, status: :created
  end


  def index
    self.content_type = "application/json"
      self.response_body = [
        $redis.get("communications") || ""
      ]
  end

  private

  def communication_params
    params.require(:communication).permit(:first_name, :last_name, :sent_at)
  end

end
