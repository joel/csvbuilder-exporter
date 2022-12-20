# frozen_string_literal: true

require "spec_helper"

module Csvbuilder
  module Export
    RSpec.describe Attribute do
      describe "instance" do
        let(:instance)        { described_class.new(:alpha, row_model) }
        let(:source_model)    { OpenStruct.new(alpha: "alpha") }
        let(:row_model)       { row_model_class.new(source_model) }

        let(:row_model_class) do
          Class.new(BasicExportModel) do
            class << self
              def format_cell(source_value, _column_name, _context)
                " - - #{source_value} - - "
              end
            end
          end
        end

        describe "#value" do
          subject(:value) { instance.value }

          it "equals the formatted_value" do
            allow(source_model).to receive(:alpha).and_call_original

            expect(value).to eql " - - alpha - - "
          end
        end

        describe "#source_value" do
          subject(:source_value) { instance.source_value }

          it "returns the row_model method" do
            allow(source_model).to receive(:alpha).and_call_original

            expect(source_value).to eql("alpha")
          end
        end
      end
    end
  end
end
