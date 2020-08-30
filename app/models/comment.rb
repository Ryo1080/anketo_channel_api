class Comment < ApplicationRecord
  validates :comment,
    presence: true,
    length: { maximum: 250 }

  belongs_to :anketo
end
