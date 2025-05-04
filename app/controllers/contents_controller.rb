class ContentsController < ApplicationController
  def index
    contents = ::Contents::ListContent.new(list_content_params).call
    render :index, formats: :json, locals: { contents: contents }
  end

  def show
    content =  Contents::GetContent.new(params[:id]).call
    render :show, formats: :json, locals: { content: content }
  end


  private

  def list_content_params
    params.require(:country)
    params.permit(:country, :type, :query)
  end
end
