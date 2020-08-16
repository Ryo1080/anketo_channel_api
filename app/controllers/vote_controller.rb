class VoteController < ApplicationController
  include ResponseMethods

  def index
    
  end

  def create
    option = AnketoOption.find(params[:option_id])
    vote = option.votes.build(ip: params[:ip])

    if vote.save
      response_success
    else
      response_internal_server_error
    end
  end
end
