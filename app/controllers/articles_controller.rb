class ArticlesController < ApplicationController

  def index
    articles = Article.recent # call in the scope -> recent (on article model)
    render json: serializer.new(articles), status: :ok  # 200
  end

  def serializer
    ArticleSerializer
  end

end
