require "active_support"
require "active_support/core_ext"
require "active_support/inflections"

require_relative 'full_circle/version'
require_relative 'full_circle/connection'
require_relative 'full_circle/parsing/response_xml_data_extractor'
require_relative 'full_circle/response_metadata'
require_relative 'full_circle/response_parser'
require_relative 'full_circle/object_builder'
require_relative 'full_circle/upcoming_event_builder'
require_relative 'full_circle/parsed_response'
require_relative 'full_circle/ad'
require_relative 'full_circle/address'
require_relative 'full_circle/coupon'
require_relative 'full_circle/response_builder'
require_relative 'full_circle/response'
require_relative 'full_circle/api'
require_relative 'full_circle/api_factory'

module FullCircle

end
