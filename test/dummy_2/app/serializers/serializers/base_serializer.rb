module Serializers
  # @abstract
  class BaseSerializer < Blueprinter::Base

    identifier(:id)

    # fields(:kind)
    fields(:display_name)
    fields(:created_at, :updated_at)

    # field(:computed_linkable_id) { |e| [e.kind, e.id.to_s].join("") }

    # ========================================================================

    view(:simple) { }

    view(:list) { }

    view(:detail) { }

    # ========================================================================

    # view(:with_tags) do
    #   fields(:tag_list)
    # end

  end
end
