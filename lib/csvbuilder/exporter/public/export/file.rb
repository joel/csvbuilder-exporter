# frozen_string_literal: true

module Csvbuilder
  module Export
    class File
      attr_reader :row_model_class, :csv, :file, :context

      # @param [Export] export_model export model class
      def initialize(row_model_class, context = {})
        @row_model_class = row_model_class
        @context = context.to_h.symbolize_keys
      end

      def headers
        row_model_class.headers(context)
      end

      # Add a row_model to the
      # @param [] source_model the source model of the export row model
      # @param [Hash] context the extra context given to the instance of the row model
      # @return [Csvbuilder::Export] the row model appended
      def append_model(source_model, context = {})
        row_model = row_model_class.new(source_model, context.reverse_merge(self.context))
        row_model.to_rows.each do |row|
          csv << row
        end
        row_model
      end
      alias << append_model

      # @return [Boolean] true, if a csv file is generated
      def generated?
        !!file
      end

      # Open a block to generate a file
      # @param [Boolean] with_headers adds the header to the file if true
      def generate(with_headers: true)
        @file = Tempfile.new([row_model_class.name, ".csv"])
        CSV.open(file.path, "wb") do |csv|
          @csv = csv
          row_model_class.setup(csv, context, with_headers: with_headers)
          yield FileProxy.new(self)
        end
      ensure
        @csv = nil
      end

      def to_s
        file.read
      end

      class FileProxy
        def initialize(file)
          @file = file
        end

        def append_model(*args)
          @file.append_model(*args)
        end
        alias << append_model
      end
    end
  end
end
