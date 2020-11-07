class AnketoController < ApplicationController
  include ResponseMethods

  def search
    render json: Anketo.build_search_response(
      keyword: params[:keyword],
      sort_id: params[:sortId],
      category_id: params[:categoryId],
    )
  end

  def show
    render json: Anketo.build_show_response(anketo_id: params[:id])
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
end
