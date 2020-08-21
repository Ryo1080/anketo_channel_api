class AnketoController < ApplicationController
  include ResponseMethods

  def index
    anketos = Anketo.all
    response = { anketos: []}
    anketos.each do |anketo|
      response[:anketos].push(
        {
          id: anketo.id,
          title: anketo.title,
          description: anketo.description,
          image: anketo.image
        }
      )
    end

    render json: response
  end

  def show
    anketo = Anketo.find(params[:id])
    options = anketo.anketo_options
    response = {
      title: anketo.title,
      description: anketo.description,
      image: anketo.image,
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

    render json: response
  end

  def create
    anketo = Anketo.new(
      title: params[:title],
      description: params[:description],
      image: params[:image]
    )

    params[:anketo_options].each do |option|
      anketo.anketo_options.build(
        option: option
      )
    end

    if anketo.save
      response_success
    else
      response_internal_server_error
    end
  end
end
