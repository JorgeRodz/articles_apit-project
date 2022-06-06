require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "#validations" do
    # Module: RSpec::Core::MemoizedHelpers::ClassMethods
    let(:article) { build(:article) } # to first stablish an article in order to use on all the test

    it "tests that factory is valid" do
      expect(article).to be_valid
      article.save!
      another_article = build(:article)
      expect(another_article).to be_valid
    end

    it 'has an invalid title' do
      article.title = ""
      expect(article).not_to be_valid
      expect(article.errors[:title]).to include("can't be blank")
    end

    it "has an invalid content" do
      article.content = ''
      expect(article).not_to be_valid
      expect(article.errors[:content]).to include("can't be blank")
    end

    it "has an invalid slug" do
      article.slug = ''
      expect(article).not_to be_valid
      expect(article.errors[:slug]).to include("can't be blank")
    end

    it "validates the uniqueness of the slug" do
      article1 = create(:article)
      expect(article1).to be_valid
      article2 = build(:article, slug: article1.slug)
      expect(article2).not_to be_valid
      expect(article2.errors[:slug]).to include('has already been taken')
    end

  end

  describe "model scope methods" do
    it "return newly created articles to olderst ones" do
      older_article = create(:article, created_at: 1.hour.ago)
      recent_article = create(:article)

      listing_articles = Article.recent
      pp listing_articles

      # rspec_core -> described_class = Article
      expect(described_class.recent).to(
        eq([recent_article, older_article])
      )

      puts "**************************"
      # pp described_class = Article
      p described_class
      puts "**************************"


      recent_article.update_column(:created_at, 2.hours.ago)

      listing_articles = Article.recent
      pp listing_articles

      # rspec_core -> described_class = Article
      expect(described_class.recent).to(
        eq([older_article, recent_article])
      )

    end

  end
end
