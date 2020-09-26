class VoteController < ApplicationController
  include ResponseMethods

  def create
    ip = request.remote_ip
    already_vote = Anketo.where(id: params[:anketoId])
      .eager_load(anketo_options: :votes)
      .where(votes: {ip: ip})
      .exists?

    return render json: { alreadyVote: already_vote } if already_vote

    option = AnketoOption.find(params[:selectedOptionId])
    vote = option.votes.build(ip: ip)

    if vote.save
      response_success
    else
      response_internal_server_error
    end
  end
end
