class ArticlesController < ApplicationController

  def index
    articles = Article.all
    render json: serializer.new(articles), status: :ok  # 200
  end

  def serializer
    ArticleSerializer
  end

end
