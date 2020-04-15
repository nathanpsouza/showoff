# frozen_string_literal: true

module WidgetHelper
  def filter_attributes(widget)
    attributes = ['id', 'name', 'description', 'kind']
    widget.slice(*attributes)
  end
end
