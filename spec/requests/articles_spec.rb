require 'rails_helper'

RSpec.describe ArticlesController do
  describe '#index' do
    it 'returns a success response' do
      get '/articles' # triggers the 'json_data' method-> api_helpers.rb
      # expect(response.status).to eq(200)
      expect(response).to have_http_status(:ok) # rspec-rails matcher
    end

    it 'returns a proper JSON for an element - ok status 200' do
      article = create :article # create - factory_bot method
      get '/articles' # triggers the 'json_data' method-> api_helpers.rb
      expect(json_data.length).to eq(1) # to check if the data return only one array
      expected = json_data.first # retrive the json data first value
      # pp expected
      aggregate_failures do
        expect(expected[:id]).to eq(article.id.to_s)
        expect(expected[:type]).to eq('article')
        expect(expected[:attributes]).to eq(
          title: article.title,
          content: article.content,
          slug: article.slug
        )
      end
    end

    it 'returns newly created articles to oldest ones' do
      older_article = create(:article, created_at: 1.hour.ago)
      # pp older_article.attributes
      recent_article = create(:article)
      # pp recent_article.attributes

      get '/articles'
      ids = json_data.map { |item| item[:id].to_i }
      expect(ids).to eql([recent_article.id, older_article.id])
    end

    it 'paginates results' do
      article1, article2, article3 = create_list(:article, 3) # crate_list -> factory_bot method
      get '/articles', params: { page: { number: 2, size: 1 } }
      expect(json_data.length).to eq(1)
      expect(json_data.first[:id]).to eq(article2.id.to_s)
    end

    it 'contains pagination links in the response' do
      article1, article2, article3 = create_list(:article, 3) # crate_list -> factory_bot method
      get '/articles', params: { page: { number: 2, size: 1 } }
      expect(json[:links].length).to eq(5)
      expect(json[:links].keys).to contain_exactly(:first, :prev, :self, :next, :last) # contain_exactly -> rspec_expectations
    end
  end
end
