# frozen_string_literal: true

# Human player class
class Player < Person
  attr_reader :name

  def initialize(name)
    super
    @name = name
  end
end
