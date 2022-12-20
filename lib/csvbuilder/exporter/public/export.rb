# frozen_string_literal: true

require "csvbuilder/core/public/model"
require "csvbuilder/exporter/concerns/export/base"
require "csvbuilder/exporter/concerns/export/attributes"

module Csvbuilder
  # Include this to with {Model} to have a RowModel for exporting to CSVs.
  module Export
    extend ActiveSupport::Concern

    include Csvbuilder::Model

    # include ActiveModel::Validations

    include Base
    include Attributes
  end
end
