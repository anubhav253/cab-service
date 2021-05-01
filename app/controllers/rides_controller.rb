# frozen_string_literal: true

class RidesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show_rides
    params.require(%i[driver_id filter])
    params.permit(:driver_id, :filter, :page_number)

    driver = Driver.find_by(id: params[:driver_id])
    if driver.nil?
      render json: { success: false, message: 'Driver does not exit' }.to_json
      return
    end
    rides = get_rides_data(params[:filter], driver.id, params[:page_number])
    render json: { success: true, message: 'Rider data', rides: rides }
  end

  def create_ride
    params.require(%i[current_location drop_location])
    params.permit(:current_location, :drop_location, :customer_id)

    ride = Ride.create!(
      status: 'searching',
      payout: 50,
      users_id: params[:customer_id],
      distance_km: 5.5,
      completed_at: 15.minutes.from_now,
      pickup_location: params[:current_location],
      drop_location: params[:drop_location]
    )
    render json: { success: true, message: 'Ride created successfully', ride: ride }
  end

  def accept_ride
    params.require(%i[ride_id])
    params.permit(:ride_id)

    ride = Ride.find_by(id: params[:ride_id])
    ride.update!(drivers_id: params[:drivers_id], status: 'accepted')
    render json: { success: true, message: 'Ride created successfully', ride: ride }
  end

  def update_ride_status
    params.require(%i[ride_id status])
    params.permit(:ride_id, :status)
    ride = Ride.find_by(id: params[:ride_id])
    ride.update!(status: params[:status])
    ride.save!
    render json: { success: true, message: 'Ride created successfully', ride: ride }
  end

  private

  def get_rides_data(filter, id, current_page=1)
    rides = []
    if filter != 'all'
      rides = Ride.where(drivers_id: id, status: filter)
    else
      rides = Ride.where(drivers_id: id)
    end
    # total_page = (rides&.count || 1) / 5
    # total_page = total_page.zero? ? 1 : total_page

    # metadata = {
    #   'total_page' => total_page,
    #   'current_page'=> current_page,
    #   'total'=> rides&.count || 0,
    # }.to_json

    # if rides.nil? || rides.empty?
    #   return { rides: [], metadata: metadata }
    # end

    # start = current_page * 5
    # end_point = (current_page+1) * 5
    { rides: rides }
  end
end
