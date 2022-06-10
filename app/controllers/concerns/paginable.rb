module Paginable
  extend ActiveSupport::Concern

  def paginate(collection)
    paginator.call(
      collection,
      params: pagination_params,
      base_url: request.url
    )
  end

  def paginator # in order to use the 'call' method inside paginate
    JSOM::Pagination::Paginator.new
  end

  def pagination_params # to obtain page -> number and page -> size . If are contain in the 'url request'
    params.permit![:page] # defaults to 20 pages - if size param is not pass
  end

  #-----------------------------------------------------------------------

  def render_collection(paginated)
    options =
      {
        meta: paginated.meta.to_h,
        links: paginated.links.to_h
      }
    result = serializer.new(paginated.items, options) # paginated.items is the array contain the items

    render json: result, status: :ok  # 200
  end

end