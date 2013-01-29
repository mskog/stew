require 'faraday'
require 'faraday_middleware'
require 'yaml'
require 'nokogiri'
require 'money'

require "stew/version"

require 'stew/web_client'
require 'stew/xml_client'
require 'stew/community_client'
require 'stew/store_client'

require 'stew/community/steam_id'
require 'stew/community/profile'
require 'stew/community/profile_friends'
require 'stew/community/profile_game'
require 'stew/community/profile_games'

require 'stew/store/app'
require 'stew/store/app_offer'

module Stew
  @config = {
    :default_community_client => CommunityClient,
    :default_store_client => StoreClient,
    :default_xml_client => XmlClient,
    :default_web_client => WebClient,
    :default_region => :us
  }

  @valid_config_keys = @config.keys

  def self.configure(opts = {})
    opts.each {|k,v| @config[k.to_sym] = v if @valid_config_keys.include? k.to_sym}
  end

  def self.config
    @config
  end

  class StewError < StandardError; end
end

Money.assume_from_symbol = true