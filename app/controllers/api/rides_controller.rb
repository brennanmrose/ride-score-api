# frozen_string_literal: true

require 'will_paginate/array'

module Api
  class RidesController < ApplicationController
    def index
      if driver
        paginated_rides = sorted_rides.paginate(page: params[:page], per_page: params[:per_page])
        render json: paginated_rides
      else
        render json: { error: 'Driver not found' }, status: :not_found
      end
    end

    private

    def driver
      @driver ||= Driver.find_by(id: permitted_params[:driver_id].to_i)
    end

    def permitted_params
      params.permit(:driver_id, :page, :per_page)
    end

    def sorted_rides
      driver.available_rides.sort { |a, b| b['score'] <=> a['score'] }
    end
  end
end
