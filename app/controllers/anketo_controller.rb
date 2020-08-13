class AnketoController < ApplicationController
  include ResponseMethods

  def index
  end

  def show
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
