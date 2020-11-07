class Anketo < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :title,
    presence: true,
    length: { maximum: 250 }
  validates :description,
    length: { maximum: 50 }

  has_many :anketo_options, dependent: :destroy
  has_many :comments, dependent: :destroy

  class << self
    def build_search_response(keyword: keyword, sort_id: sort_id, category_id: category_id)
      # 入力されたkeywordで検索
      anketos = Anketo.where('title LIKE ?',"%#{keyword}%")

      # 選択されたcategoryで検索
      anketos = anketos.where(category: category_id) unless category_id.to_i == 0

      # 選択されたsort順に並び替え
      case sort_id.to_i
      when 0
        anketos = anketos.order(created_at: :desc)
      when 1
        anketos = anketos
          .left_joins(anketo_options: :votes)
          .group("anketos.id")
          .order(Arel.sql('count(votes.id) desc'))
          .where(created_at: Time.now.months_ago(1).beginning_of_day...Time.now)
      when 2
        anketos = anketos
          .left_joins(anketo_options: :votes)
          .group("anketos.id")
          .order(Arel.sql('count(votes.id) desc'))
      end

      vote_counts = AnketoOption.joins(:votes).group(:anketo_id).count('votes.id')
      response = { anketos: []}
      anketos.each do |anketo|
        response[:anketos].push(
          {
            id: anketo.id,
            title: anketo.title,
            category: anketo.category,
            image: anketo.image,
            voteCount: vote_counts[anketo.id] || 0
          }
        )
      end

      response
    end

    def build_show_response(anketo_id: anketo_id)
      anketo = Anketo.find(anketo_id)
  
      options = anketo.anketo_options
      response = {
        id: anketo.id,
        title: anketo.title,
        description: anketo.description,
        image: anketo.image.to_s,
        category: anketo.category,
        options: []
      }
      options.each do |option|
        response[:options].push(
          {
            id: option.id,
            option: option.option,
            votes: option.votes.size
          }
        )
      end
  
      response
    end
  end
end
