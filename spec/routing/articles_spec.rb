require 'rails_helper'

RSpec.describe "/articles routes" do

  it "routes to articles#index" do
    # aggregate_failures - rspec-expectations -> To not stop at the first error...and see all the error messages
    aggregate_failures do
      # expect(get '/articles').to route_to(controller: 'articles', action: 'index')
      expect(get '/articles').to route_to('articles#index') # short syntax - same as above line code
      expect(get '/articles?page[number]=3').to route_to('articles#index', "page"=>{"number"=>"3"})
    end
  end

  it "route to article#show" do
    expect(get 'articles/1').to route_to('articles#show', id: '1')
  end

end