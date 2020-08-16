class AnketoController < ApplicationController
  include ResponseMethods

  def index
    anketos = Anketo.all
    response = { anketos: []}
    anketos.each do |anketo|
      response[:anketos].push(
        {
          title: anketo.title,
          desctiption: anketo.desctiption,
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
      desctiption: anketo.desctiption,
      image: anketo.image,
      options: []
    }
    options.each do |option|
      response[:options].push({ option: option.option })
    end

    render json: response
  end

  def create
    anketo = Anketo.new(
      title: params[:title],
      desctiption: params[:desctiption],
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

  def update
  end

  def destroy
  end
end
