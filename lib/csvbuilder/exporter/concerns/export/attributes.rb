# frozen_string_literal: true

require "csvbuilder/core/concerns/attributes_base"
require "csvbuilder/exporter/internal/export/attribute"

module Csvbuilder
  module Export
    module Attributes
      extend ActiveSupport::Concern
      include AttributesBase

      included do
        ensure_attribute_method
      end

      def attribute_objects
        @attribute_objects ||= array_to_block_hash(self.class.column_names) do |column_name|
          Attribute.new(column_name, self)
        end
      end

      class_methods do
        protected

        def define_attribute_method(column_name)
          super { source_model.public_send(column_name) }
        end
      end
    end
  end
end
