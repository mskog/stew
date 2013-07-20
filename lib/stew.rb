# encoding: utf-8

require 'faraday'
require 'faraday_middleware'
require 'yaml'
require 'nokogiri'
require 'money'

require "stew/version"

require 'stew/community/steam_id_resolver'
require 'stew/community/web_client'
require 'stew/community/web_api_client'
require 'stew/community/steam_id'
require 'stew/community/avatar'
require 'stew/community/profile'
require 'stew/community/profile_friends'
require 'stew/community/profile_game'
require 'stew/community/profile_games'

require 'stew/store/web_client'
require 'stew/store/store_client'
require 'stew/store/sales_client'
require 'stew/store/app'
require 'stew/store/app_offers'
require 'stew/store/app_offer'
require 'stew/store/app_offer_sale'
require 'stew/store/sales'
require 'stew/store/sale'

module Stew
  Money.assume_from_symbol = true
  
  @config = {
    :default_community_client => Community::WebApiClient,
    :default_store_client => Store::StoreClient,
    :default_web_client => Store::WebClient,
    :default_region => :us,
    :steam_api_key => nil
  }

  @valid_config_keys = @config.keys

  def self.configure(opts = {})
    opts.each {|key,value| @config[key] = value if @valid_config_keys.include? key}
  end

  def self.config
    @config
  end

  def self.money(price)
    if price.nil? == false && price.include?("€")
      Money.parse(price[-1,1]+price[0..-2])
    else
      Money.parse price
    end
  end

  #Base error
  class StewError < StandardError; end
end
