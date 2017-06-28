require "mercadolibre/version"

# mercadolibre -> core
require "mercadolibre/core/categories_and_listings"
require "mercadolibre/core/collections"
require "mercadolibre/core/deals"
require "mercadolibre/core/items_and_searches"
require "mercadolibre/core/locations_and_currencies"
require "mercadolibre/core/metrics"
require "mercadolibre/core/oauth"
require "mercadolibre/core/orders_and_feedback"
require "mercadolibre/core/questions_and_answers"
require "mercadolibre/core/shipping"
require "mercadolibre/core/users_and_apps"

# mercadolibre -> api
require "mercadolibre/api"

# mercadopago -> core
require "mercadopago/core/oauth"
require "mercadopago/core/payments"

# mercadopago -> api
require "mercadopago/api"

# dependencies
require 'rest-client'
require 'singleton'
require 'time'
require 'json'
require 'ostruct'
