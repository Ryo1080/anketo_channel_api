class AnketoOption < ApplicationRecord
  has_many :votes, dependent: :destroy
  belongs_to :anketo
end
