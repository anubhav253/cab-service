# frozen_string_literal: true

class Ride < ApplicationRecord
  belongs_to :users
  belongs_to :drivers
end
