# frozen_string_literal: true

require "csvbuilder/core/internal/attribute_base"

module Csvbuilder
  module Export
    class Attribute < Csvbuilder::AttributeBase
      def value
        formatted_value
      end

      def source_value
        row_model.public_send(column_name)
      end
    end
  end
end
