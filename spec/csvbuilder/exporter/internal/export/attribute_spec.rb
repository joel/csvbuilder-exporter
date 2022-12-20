# frozen_string_literal: true

require "spec_helper"

module Csvbuilder
  module Export
    RSpec.describe Attribute do
      describe "instance" do
        let(:instance)        { described_class.new(:string1, row_model) }
        let(:row_model_class) { Class.new BasicExportModel }
        let(:source_model)    { OpenStruct.new(string1: "1.01") }
        let(:row_model)       { row_model_class.new(source_model) }

        it_behaves_like "has_needed_value_methods"

        describe "#value" do
          subject(:value) { instance.value }

          it "equals the formatted_value" do
            allow(instance).to receive(:formatted_value).and_return("stub")
            expect(value).to eql "stub"
          end
        end

        describe "#source_value" do
          subject(:source_value) { instance.source_value }

          it "returns the row_model method" do
            allow(source_model).to receive(:string1).and_call_original
            expect(source_value).to eql("1.01")
          end
        end
      end
    end
  end
end
