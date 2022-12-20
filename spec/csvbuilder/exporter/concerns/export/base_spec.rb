# frozen_string_literal: true

require "spec_helper"

module Csvbuilder
  module Export
    RSpec.describe Base do
      let(:source_model)    { BasicModel.new("Test 1", "Test 2") }
      let(:row_model_class) { Class.new(BasicExportModel) }
      let(:instance)        { row_model_class.new(source_model) }

      describe "instance" do
        describe "#to_row" do
          subject(:to_row) { instance.to_row }

          it "return an array with model attribute values" do
            expect(to_row).to eql ["Test 1", "Test 2"]
          end

          context "with attribute overwritten" do
            before do
              row_model_class.class_eval do
                def alpha
                  "whatever"
                end
              end
            end

            it "return an array with the override" do
              expect(to_row).to eql ["whatever", "Test 2"]
            end
          end

          context "with format_cell" do
            before do
              row_model_class.class_eval do
                def self.format_cell(*args)
                  args.join("__")
                end
              end
            end

            it "return an array with the override" do
              expect(to_row).to eql ["Test 1__alpha__#<OpenStruct>", "Test 2__string2__#<OpenStruct>"]
            end
          end
        end
      end
    end
  end
end
