class VocabulariesController < ApplicationController
  before_action :get_cards, only: :index

  def index
    @card = @cards["vocabulary"][rand(@cards.size)]
    @card
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
      req.url "/vocabularies?level=#{params[:level]}&page=2"
    end
    response
  end

  def url
    "http://dry-refuge-1311.herokuapp.com/"
  end

  def get_cards
    @cards ||= ActiveSupport::JSON.decode api_get_connection.body
  end
end
