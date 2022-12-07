# frozen_string_literal: true

# This is a base class for services that need to be initialized with an array of ids.
class BaseService2
  attr_reader :ids

  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @ids = args[:ids]
  end

  # To be implemented by the child class
  def call; end
end
