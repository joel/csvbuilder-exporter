# frozen_string_literal: true

class BasicModel
  attr_accessor :alpha, :beta

  def initialize(alpha, beta)
    @alpha = alpha
    @beta = beta
  end

  def string_value(number)
    "Value Of String #{number}"
  end
end
