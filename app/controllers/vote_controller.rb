class VoteController < ApplicationController
  include ResponseMethods

  def create
    option = AnketoOption.find(params[:optionId])
    vote = option.votes.build(ip: params[:ip])

    if vote.save
      response_success
    else
      response_internal_server_error
    end
  end
end
