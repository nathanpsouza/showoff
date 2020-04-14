# frozen_string_literal: true

class User
  include ActiveModel::Model

  attr_accessor :email,
    :first_name,
    :last_name,
    :password,
    :password_confirmation

  validates :email, {
    presence: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }
  }
  validates :password,
    confirmation: true,
    length: { minimum: 8 },
    if: -> { password.present? }

  def to_hash
    {
      first_name: @first_name,
      last_name: @last_name,
      email: @email,
      password: @password
    }
  end
end
