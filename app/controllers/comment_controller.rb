class CommentController < ApplicationController
  include ResponseMethods

  def index
    anketo = Anketo.find(params[:anketo_id])
    comments = anketo.comments.map do |comment|
      {
        id: comment.id,
        comment: comment.comment
      }
    end
    response = { comments: comments }
    render json: response
  end

  def create
    anketo = Anketo.find(params[:anketo_id])
    comment = anketo.comments.build(comment: params[:comment])

    if comment.save
      response_success
    else
      response_internal_server_error
    end
  end
end
