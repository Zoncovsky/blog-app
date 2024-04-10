# frozen_string_literal: true

class Post < ApplicationRecord
  include AASM
  extend Enumerize

  belongs_to :user

  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [300, 300]
  end

  enumerize :post_type,
            in: %i[text_post selling],
            default: :text_post,
            predicates: true,
            scope: true

  scope :published_or_pending_for_user, lambda { |user_id|
    where("status = 'published' OR (user_id = ? AND status = 'pending') OR (user_id = ? AND status = 'cancelled')", user_id, user_id)
  }

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value note status updated_at user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['user']
  end

  aasm :status, no_direct_assignment: true do
    state :pending, initial: true
    state :pending, :published, :cancelled

    event :make_published do
      transitions from: %i[pending cancelled], to: :published
    end

    event :cancel do
      transitions from: %i[pending published], to: :cancelled
    end
  end
end
