Mercadolibre
==============

Mercadolibre gem implements MELI API (Official API available to interact with Mercadolibre).

It implements most of the methods of the official API and it makes it very easy to interact with.

Requirements
-----------------

You need to create an application in http://applications.mercadolibre.com in order to get app key and app secret.

Rest Client is used to perform all API calls.


Installation
-----------------

```console
gem install mercadolibre
```

Getting started
-----------------

MELI uses OAuth protocol for authentication, so you first need to get an access token.

In order to do that you first need to instance the API:

```ruby
api = Mercadolibre::Api.new({
  app_key: 'YOUR_APP_KEY',
  app_secret: 'YOUR_APP_SECRET',
  callback_url: 'YOUR_CALLBACK_URL',
  site: 'YOUR_SITE_COUNTRY'
})
```

Site country is the site id for the country you are using (eg. Argentina's site id is MLA).

In case you already have an access token, it could be passed directly in the constructor hash or it can be assigned through property 'access_token'.

To get a url of mercadolibre authentication page you can call authenticate_url method:

```ruby
# it returns the authentication page you should send user to
api.authenticate_url
```

After authentication, you'll be redirected to callback url with an auth code (code variable from return url). With this code, you'll get access token (also refresh token in case you need it).

```ruby
# auth_data (access_token, refresh_token, expired_at)
auth_data = api.authenticate(your_auth_code)
```

As soon as you are authenticated and you have a valid access token, you are all set for using the API.


API Methods
-----------------

##### Auth

```ruby
# Returns mercadolibre authentication url.
api.authenticate_url

# Returns authentication tokens with auth code provided in callback url.
api.authenticate(auth_code)

# Extends token expiration (useful to keep alive a token).
api.update_token(refresh_token)
```

##### Categories and listings

```ruby
# Returns all available sites.
api.get_sites

# Returns data of specific site.
api.get_site(site_id)

# Returns data of specific site domain (eg. mercadolibre.com.ar).
api.get_site_domain_info(domain)

# Return all listing types available for the site.
api.get_listing_types(site_id)

# Return all listing exposures available for the site.
api.get_listing_exposures(site_id)

# Return all listing prices that matches with the given filters.
# Possible filters are:
# - price
# - listing_type_id
# - quantity
# - category_id
# - currency_id
api.get_listing_prices(filters)

# Returns main site categories.
api.get_site_categories(site_id)
```

##### Items and searches

```ruby
# Search all your item ids with filters (without pagination).
api.get_all_my_item_ids(filters={})

# Search all your item ids with filters (with pagination).
api.get_my_item_ids(filters={})

# Search all item ids with filters (without pagination).
api.get_all_item_ids(filters={})

# Search all item ids with filters (with pagination).
api.get_item_ids(filters={})

# Gets item detail.
api.get_item(item_id)

# Gets items visits. If you provide an item id as a string you'll get an integer.
# If you pass an array of item ids, you'll get a hash with the items visits for each.
api.get_item_visits(item_ids)

# Gets all item descriptions from an item.
api.get_item_descriptions(item_id)

# Gets all available listing types for upgrade for the item.
api.get_item_available_upgrades(item_id)

# Gets search url for the site and query.
api.get_search_url(site_id, q)

# Gets category hot items.
api.get_hot_items(site_id, category_id, limit=15)

# Gets featured items.
api.get_featured_items(site_id, pool_id)

# Gets site trends for category.
api.get_site_trends(site_id, category_id)

# Checks if attributes are valid for creating an item.
api.item_valid?(attribs)

# Creates an item.
api.create_item(attribs)

# Relists an item.
api.relist_item(item_id, price, quantity, listing_type_id)

# Updates item fields (price, stock, etc).
api.update_item_fields(item_id, attribs)

# Updates item listing type.
api.update_item_listing_type(item_id, listing_type_id)

# Adds description to item.
api.add_item_description(item_id, text)

# Update item description.
api.update_item_description(item_id, text)
```

##### Locations and currencies

```ruby
# Gets countries.
api.get_countries

# Gets country.
api.get_country(country_id)

# Gets state.
api.get_state(state_id)

# Gets city.
api.get_city(city_id)

# Gets currencies
api.get_currencies

# Gets currency info
api.get_currency(currency_id)

# Gets currency conversion rate
api.currency_convertion_rate(currency_from, currency_to)

# Gets zip code info
api.get_zip_code_info(country_id, zip_code)
```

##### Order management

```ruby
# Get all orders with filters (without pagination)
api.get_all_orders(filters={})

# Get all orders with filters (with pagination)
api.get_orders(filters={})

# Gets order detail
api.get_order(order_id)

# Gets both seller and buyer feedbacks
api.get_order_feedbacks(order_id)

# Gets buyer feedback
api.get_buyer_feedback(order_id)

# Gets seller feedback
api.get_seller_feedback(order_id)

# Gives feedback to order
api.give_feedback_to_order(order_id, feedback_data)

# Updates feedback from order. Kind is seller or buyer.
api.change_feedback_from_order(order_id, kind, feedback_data)

# Reply a feedback. Kind is seller or buyer.
api.reply_feedback(order_id, kind, text)

# Get all payment methods from site.
api.get_site_payment_methods(site_id)

# Get all users restricted to purchase you an item.
api.get_order_blacklist(user_id)
```

##### Questions

```ruby
# Get all questions with filters (without pagination)
api.get_all_questions(filters={})

# Get all questions with filters (with pagination)
api.get_questions(filters={})

# Gets question detail
api.get_question(question_id)

# Deletes question
api.delete_question(question_id)

# Asks a question
api.ask_question(item_id, text)

# Answers a question
api.answer_question(question_id, text)

# Get all blacklisted users
api.get_blacklisted_users_ids(seller_id)

# Adds user to blacklist
api.add_user_to_blacklist(seller_id, user_id)

# Removes user from blacklist
api.remove_user_from_blacklist(seller_id, user_id)
```

##### Users

```ruby
# Gets current user
api.get_my_user

# Gets user detail
api.get_user(user_id)

# Get all users with user_id from array
api.get_users(user_ids)

# Get all accepted payment methods for the user.
api.get_user_accepted_payment_methods(user_id)
```

**Note:** For further details about the methods, params and possible errors please check https://api.mercadolibre.com.

Problems?
-----------------

If you are encountering what you think is a bug, please open an issue.

Todo
-----------------

Error handling should be improved to capture errors for common errors, already quoted on meli API.


Author
-----------------

Matias Hick (me@unformatt.com.ar)
