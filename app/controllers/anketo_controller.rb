class AnketoController < ApplicationController
  include ResponseMethods

  def index
    anketos = Anketo.all.order(created_at: :desc)
    render json: build_anketo_response(anketos)
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

  def search
    anketos = Anketo.where('title LIKE ?',"%#{params[:keyword]}%")

    case params[:sortId].to_i
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

    # TODO categoryで検索

    render json: build_anketo_response(anketos)
  end

  private

    def build_anketo_response(anketos)
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

      response
    end
end
