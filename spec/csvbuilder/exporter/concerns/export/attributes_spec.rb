# frozen_string_literal: true

require "spec_helper"

module Csvbuilder
  module Export
    RSpec.describe Attributes do
      let(:source_model) { BasicModel.new("a", "b") }
      let(:instance)     { row_model_class.new(source_model) }

      describe "instance" do
        let(:row_model_class) { BasicExportModel }

        describe "#attribute_objects" do
          subject(:attribute_objects) { instance.attribute_objects }

          it "returns a hash of attribute_objects mapped to their column_name" do
            expect(attribute_objects.keys).to eql row_model_class.column_names
            expect(attribute_objects.values.map(&:class)).to eql [Csvbuilder::Export::Attribute] * 2
          end
        end
      end

      describe "class" do
        let(:row_model_class) do
          Class.new do
            include Csvbuilder::Model
            include Csvbuilder::Export
          end
        end

        it_behaves_like "defines_attributes_methods_safely", alpha: "a", string2: "b"

        describe "::column" do
          it_behaves_like "column_method", Csvbuilder::Export, alpha: "a", string2: "b"
        end

        describe "::define_attribute_method" do
          subject(:define_attribute_method) { row_model_class.send(:define_attribute_method, :waka) }
          it "makes an attribute that calls the source_model column_name method" do
            define_attribute_method
            allow(source_model).to receive(:waka).with(no_args).and_return("tested")
            expect(instance.waka).to eql "tested"
          end

          it_behaves_like "define_attribute_method"
        end
      end
    end
  end
end
