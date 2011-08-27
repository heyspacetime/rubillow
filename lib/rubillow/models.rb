require "nokogiri"
require "active_support/core_ext/string"
require "active_support/inflector"

module Rubillow
  # Sub module for returned and parsed web service data
  module Models
    # Base class for data models
    class Base
      # @return [String] the raw XML content from the service
      attr_accessor :xml
      # @private
      attr_accessor :parser
      # @return [String] response message
      attr_accessor :message
      # @return [Integer] response code
      attr_accessor :code
      # @return [Boolean] nearing API's daily request limit
      attr_accessor :near_limit
    
      # @private
      # Initialize the model
      #
      # @param [String] xml the raw XML from the service
      def initialize(xml)
        if !xml.blank?
          @xml = xml
          @parser = Nokogiri::XML(xml) { |cfg| cfg.noblanks }
          parse
        end
      end
    
      # Was the request successful?
      # @return [Boolean] +true+ on successful request
      def success?
        @code.to_i == 0
      end
    
      protected
      
      # @private
      # Parses the xml content
      def parse
        @message = @parser.xpath('//message/text').text
        @code = @parser.xpath('//message/code').text.to_i
        
        limit = @parser.xpath('//message/limit-warning')
        @near_limit = !limit.empty? && limit.text.downcase == "true"
      end
    end
  end
end

require "rubillow/models/zpidable"
require "rubillow/models/linkable"
require "rubillow/models/addressable"
require "rubillow/models/zestimateable"
require "rubillow/models/property_basics"
require "rubillow/models/images"
require "rubillow/models/search_result"
require "rubillow/models/chart"
require "rubillow/models/property_chart"
require "rubillow/models/comps"
require "rubillow/models/rate_summary"
require "rubillow/models/monthly_payments"
require "rubillow/models/postings"
require "rubillow/models/posting"
require "rubillow/models/deep_search_result"
require "rubillow/models/deep_comps"
require "rubillow/models/updated_property_details"
require "rubillow/models/demographics"
require "rubillow/models/demographic_value"
require "rubillow/models/region_children"
require "rubillow/models/region_chart"
require "rubillow/models/region"