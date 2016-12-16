require "mercadolibre/version"

# mercadolibre -> core
require "mercadolibre/core/auth"
require "mercadolibre/core/categories_and_listings"
require "mercadolibre/core/collections"
require "mercadolibre/core/items_and_searches"
require "mercadolibre/core/locations_and_currencies"
require "mercadolibre/core/order_management"
require "mercadolibre/core/questions"
require "mercadolibre/core/shippings"
require "mercadolibre/core/users"

# mercadolibre -> api
require "mercadolibre/api"

# mercadopago -> core
require "mercadopago/core/auth"
require "mercadopago/core/payments"

# mercadopago -> api
require "mercadopago/api"

# dependencies
require 'rest-client'
require 'singleton'
require 'time'
require 'json'
require 'ostruct'
