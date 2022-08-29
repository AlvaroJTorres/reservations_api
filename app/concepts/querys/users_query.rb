# frozen_string_literal: true

module Querys
  # Queries for User Model
  class UsersQuery
    attr_reader :relation

    def initialize(relation = User.all)
      @relation = relation
    end

    def list_managers
      relation.where(role: 2)
    end
  end
end
