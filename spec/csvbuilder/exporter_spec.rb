# frozen_string_literal: true

module Csvbuilder
  RSpec.describe Exporter do
    it "has a version number" do
      expect(Csvbuilder::Exporter::VERSION).not_to be_nil
    end
  end
end
