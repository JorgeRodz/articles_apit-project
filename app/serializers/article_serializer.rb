class ArticleSerializer
  include JSONAPI::Serializer
  set_type :articles # in order to receive -> type: "articles" not type: "article"
  attributes :title, :content, :slug
end
