# frozen_string_literal: true

class BasicModel
  attr_accessor :alpha, :beta

  def initialize(alpha, beta)
    @alpha = alpha
    @beta = beta
  end
end
