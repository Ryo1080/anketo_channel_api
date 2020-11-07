class CommentController < ApplicationController
  include ResponseMethods

  def index
    anketo = Anketo.find(params[:anketo_id])
    render json: Comment.build_index_response(anketo: anketo)
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
