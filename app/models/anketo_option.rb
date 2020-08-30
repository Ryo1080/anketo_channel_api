class AnketoOption < ApplicationRecord
  validates :option,
    presence: true,
    length: { maximum: 50 }

  has_many :votes, dependent: :destroy
  belongs_to :anketo
end
