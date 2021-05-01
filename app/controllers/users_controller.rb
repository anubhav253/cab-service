# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show_rides
    params.require(%i[user_id filter])
    params.permit(:user_id, :filter, :page_number)

    user = User.find_by(id: params[:user_id])
    if user.nil?
      render json: { success: false, message: 'User does not exit' }.to_json
      return
    end
    rides = get_rides_data(params[:filter], user.id, params[:page_number])
    render json: { success: true, message: 'User rides data', rides: rides }
  end

  private

  def get_rides_data(filter, id, current_page=1)
    rides = []
    if filter != 'all'
      rides = Ride.where(users_id: id, status: filter)
    else
      rides = Ride.where(users_id: id)
    end

    # start = current_page * 5
    # end_point = (current_page+1) * 5
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

    { rides: rides }
  end

end
