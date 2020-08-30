class Anketo < ApplicationRecord
  validates :title,
    presence: true,
    length: { maximum: 250 }
  validates :description,
    length: { maximum: 50 }

  has_many :anketo_options, dependent: :destroy
  has_many :comments, dependent: :destroy
end
