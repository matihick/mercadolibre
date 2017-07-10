require "mercadolibre/version"

# mercadolibre -> core
require "mercadolibre/core/apps"
require "mercadolibre/core/bookmarks"
require "mercadolibre/core/categories"
require "mercadolibre/core/currencies"
require "mercadolibre/core/deals"
require "mercadolibre/core/feedbacks"
require "mercadolibre/core/item_variations"
require "mercadolibre/core/items"
require "mercadolibre/core/listings"
require "mercadolibre/core/locations"
require "mercadolibre/core/messaging"
require "mercadolibre/core/metrics"
require "mercadolibre/core/money"
require "mercadolibre/core/oauth"
require "mercadolibre/core/order_blacklist"
require "mercadolibre/core/order_notes"
require "mercadolibre/core/orders"
require "mercadolibre/core/pictures"
require "mercadolibre/core/projects"
require "mercadolibre/core/question_blacklist"
require "mercadolibre/core/questions"
require "mercadolibre/core/searching"
require "mercadolibre/core/shipping"
require "mercadolibre/core/users"

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
