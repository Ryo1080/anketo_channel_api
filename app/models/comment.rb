class Comment < ApplicationRecord
  validates :comment,
    presence: true,
    length: { maximum: 250 }

  belongs_to :anketo

  class << self
    def build_index_response(anketo: anketo)
      comments = anketo.comments.order(created_at: :desc).map do |comment|
        {
          id: comment.id,
          comment: comment.comment,
          timestamp: comment.created_at.strftime("%Y年%m月%d日 %H:%M:%S"),
        }
      end

      { comments: comments }
    end
  end
end
