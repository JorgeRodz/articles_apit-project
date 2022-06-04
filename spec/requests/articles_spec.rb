require 'rails_helper'

RSpec.describe ArticlesController do
  describe "#index" do

    it "returns a success response" do
      get '/articles'
      # expect(response.status).to eq(200)
      expect(response).to have_http_status(:ok) # rspec-rails matcher
    end

    it "returns a proper JSON - ok status 200" do
      article = create :article   # create - factory_bot method
      get '/articles'
      body = JSON.parse(response.body).deep_symbolize_keys
      pp body # to see in pretty(nested) format the response
      expect(body).to eq(
        data: [
          {
            id: article.id.to_s,
            type: 'articles',
            attributes: {
              title: article.title,
              content: article.content,
              slug: article.slug
            }
          }
        ]
      )
    end

  end
end
