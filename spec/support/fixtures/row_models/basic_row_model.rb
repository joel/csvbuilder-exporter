# frozen_string_literal: true

class BasicRowModel
  include Csvbuilder::Model

  column :alpha
  column :string2, header: "String 2"
end

#
# Export
#
class BasicExportModel < BasicRowModel
  include Csvbuilder::Export
end
