class AnketoController < ApplicationController
  include ResponseMethods

  def index
    anketos = Anketo.all.order(created_at: :desc)
    render json: build_anketos_response(anketos)
  end

  def show
    anketo = Anketo.find(params[:id])

    options = anketo.anketo_options
    response = {
      title: anketo.title,
      description: anketo.description,
      image: anketo.image.to_s,
      category: anketo.category,
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
      image: params[:image],
      category: params[:categoryId],
    )

    params[:anketoOptions].each do |option|
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

  def destroy
    # TODO anketo削除処理
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

    anketos = anketos.where(category: params[:categoryId]) unless params[:categoryId].to_i == 0

    render json: build_anketos_response(anketos)
  end

  private

    def build_anketos_response(anketos)
      response = { anketos: []}
      anketos.each do |anketo|
        response[:anketos].push(
          {
            id: anketo.id,
            title: anketo.title,
            category: anketo.category,
            image: anketo.image,
            voteCount: anketo.anketo_options.joins(:votes).count
          }
        )
      end

      response
    end
end
