class ArticlesController < ApplicationController
  include Paginable

  def index
    paginated = paginate(Article.recent) # call in the scope -> recent (on article model)
    render_collection(paginated) # method call to concerns/paginable.rb
  end

  # method necessary to serializer a json with the json:api standard response
  def serializer
    ArticleSerializer
  end

end
