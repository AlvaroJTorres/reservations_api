# frozen_string_literal: true

module Manager
  # Methods for all controllers
  class ApplicationController < ApplicationController
    before_action -> { doorkeeper_authorize! :manager }
  end
end
