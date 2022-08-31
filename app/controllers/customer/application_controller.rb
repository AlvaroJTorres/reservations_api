# frozen_string_literal: true

module Customer
  # Methods for all controllers
  class ApplicationController < ApplicationController
    before_action -> { doorkeeper_authorize! :customer }
  end
end
