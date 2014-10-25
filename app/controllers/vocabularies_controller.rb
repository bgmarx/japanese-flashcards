class VocabulariesController < ApplicationController
  before_action :get_cards, only: :index

  def index
    @card = vocabulary_card.merge(page_total)
  end

  def new
  end

  def show
  end

  protected

   def api_connection
     Faraday.new(:url => url, :ssl => { :verify => false }) do |faraday|
       faraday.request  :url_encoded
       faraday.response :logger
       faraday.adapter  Faraday.default_adapter
     end
   end

  def api_get_connection
    response = api_connection.get do |req|
      req.url "/vocabularies?level=#{params[:level]}"
    end
    response
  end

  def vocabulary_card
    @paginated_cards = @cards["vocabulary"]["vocabulary_card"]
    @paginated_cards[rand(@paginated_cards.size)]
  end

  def page_total
    { total_num_pages: @cards["vocabulary"]["vocabulary_page_total"] }
  end

  def url
    "http://localhost:4000/"
    #"http://dry-refuge-1311.herokuapp.com/"
  end

  def get_cards
    @cards ||= ActiveSupport::JSON.decode api_get_connection.body
  end
end
