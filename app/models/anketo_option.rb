class AnketoOption < ApplicationRecord
  has_many :vote, dependent: :destroy
  belongs_to :anketo
end
