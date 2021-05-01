# frozen_string_literal: true

class DriversController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    params.require(%i[name phone_number])
    params.permit(:name, :phone_number)

    driver = Driver.find_by(mobile_number: params[:phone_number])
    unless driver.nil?
      render json: { success: false, message: 'Driver already exits' }.to_json
      return
    end

    driver = Driver.create!(name: params[:name], mobile_number: params[:phone_number])

    render json: { success: true, message: 'User created successfully', driver: driver }
  end
end
