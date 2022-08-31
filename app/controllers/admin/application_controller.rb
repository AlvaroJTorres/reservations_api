# frozen_string_literal: true

module Admin
  # Methods for all controllers
  class ApplicationController < ApplicationController
    before_action -> { doorkeeper_authorize! :admin }
  end
end
