class KanjiController < ApplicationController
  before_action :get_cards, only: :index

  def index
    @card = @cards[rand(@cards.size)]
    @card
  end

  def new
  end

  def show
  end

  protected

  def get_cards
    Faraday.new
  end

  def api_connection
    Faraday.new(:url => url, :ssl => { :verify => false }) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def api_put_connection(patch)
    api_connection.put do |req|
      req.url "/patches.json?v=#{patch[:patches].first[:version]}&t=#{topic}"
      req.headers['Content-Type'] = 'application/json'
      req.body = patch.to_json
    end
  end

  def api_get_connection
    response = api_connection.get do |req|
      req.url "/kanjis"
    end
    response
  end

  def url
    #if Rails.env == "development"
    #  "http://localhost:4000/"
    #else
    #"http://dry-refuge-1311.herokuapp.com/"
    #end
    "http://dry-refuge-1311.herokuapp.com/"

  end

  def get_cards
    @cards ||= ActiveSupport::JSON.decode api_get_connection.body
  end
end
