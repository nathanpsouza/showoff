# frozen_string_literal: true

class Widget
  include ActiveModel::Model

  attr_accessor :id, :name, :description, :kind

  validates :name, presence: true
  validates :description, presence: true
  validates :kind, presence: true, inclusion: { in: ['visible', 'hidden'] }

  def to_hash
    {
      name: @name,
      description: @description,
      kind: @kind
    }
  end
end
