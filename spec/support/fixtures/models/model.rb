# frozen_string_literal: true

class BasicModel
  attr_accessor :alpha, :string2

  def initialize(alpha, string2)
    @alpha = alpha
    @string2 = string2
  end

  def string_value(number)
    "Value Of String #{number}"
  end
end
