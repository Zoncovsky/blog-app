# frozen_string_literal: true

require 'open-uri'

class User < ApplicationRecord
  extend Enumerize

  has_many :posts

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [300, 300]
    attachable.variant :min, resize_to_limit: [200, 200]
  end

  validates :first_name,
            :last_name,
            :nickname,
            :role,
            presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :timeoutable, :confirmable,
         :omniauthable, omniauth_providers: %i[google_oauth2 github]

  enumerize :role,
            in: %i[user admin],
            default: :user,
            predicates: true,
            scope: true

  scope :with_admin_role, -> { where(role: :admin) }
  scope :with_user_role, -> { where(role: :user) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[email first_name id last_name nickname phone_number role]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end

  def full_name
    "#{first_name} #{last_name}".titleize
  end

  def display_name
    return email if full_name.blank?

    full_name
  end
end
