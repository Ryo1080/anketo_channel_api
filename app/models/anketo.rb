class Anketo < ApplicationRecord
  has_many :anketo_options, dependent: :destroy
  has_many :comments, dependent: :destroy
end
