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

    gem install mercadolibre


Getting started
-----------------

MELI uses OAuth protocol for authentication, so you first need to get an access token.

In order to do that you first need to instance the API:

    api = Mercadolibre::Api.new({
      app_key: 'YOUR_APP_KEY',
      app_secret: 'YOUR_APP_SECRET',
      callback_url: 'YOUR_CALLBACK_URL',
      site: 'YOUR_SITE_COUNTRY'
    })

Site country is the site id for the country you are using (eg. Argentina's site id is MLA).

In case you already have an access token, it could be passed directly in the constructor hash or it can be assigned through property 'access_token'.

To get a url of mercadolibre authentication page you can call authenticate_url method:

    # it returns the authentication page you should send user to
    api.authenticate_url

After authentication, you'll be redirected to callback url with an auth code (code variable from return url). With this code, you'll get access token (also refresh token in case you need it).

    # auth_data (access_token, refresh_token, expired_at)
    auth_data = api.authenticate(your_auth_code)

As soon as you are authenticated and you have a valid access token, you are all set for using the API.


API Methods
-----------------

##### Auth

    * api.authenticate_url
      -> Returns mercadolibre authentication url.

    * api.authenticate(auth_code)
      -> Returns authentication tokens with auth code provided in callback url.

    * api.update_token(refresh_token)
      -> Extends token expiration (useful to keep alive a token).

##### Categories and listings

    * api.get_sites
      -> Returns all available sites.

    * api.get_site(site_id)
      -> Returns data of specific site.

    * api.get_site_domain_info(domain)
      -> Returns data of specific site domain (eg. mercadolibre.com.ar).

    * api.get_listing_types(site_id)
      -> Return all listing types available for the site.

    * api.get_listing_exposures(site_id)
      -> Return all listing exposures available for the site.

    * api.get_listing_prices(filters)
      -> Return all listing prices that matches with the given filters.
         Possible filters are:
         - price
         - listing_type_id
         - quantity
         - category_id
         - currency_id

    * api.get_site_categories(site_id)
      -> Returns main site categories.

##### Items and searches

    * api.get_my_item_ids(filters={})
      -> Search all your item ids with filters (with pagination).

    * api.get_item_ids(filters={})
      -> Search all item ids with filters (with pagination).

    * api.get_item(item_id)
      -> Gets item detail.

    * api.get_item_visits(item_ids)
      -> Gets items visits. If you provide an item id as a string you'll get an integer.
         If you pass an array of item ids, you'll get a hash with the items visits for each.

    * api.get_item_descriptions(item_id)
      -> Gets all item descriptions from an item.

    * api.get_item_available_upgrades(item_id)
      -> Gets all available listing types for upgrade for the item.

    * api.get_search_url(site_id, q)
      -> Gets search url for the site and query.

    * api.get_hot_items(site_id, category_id, limit=15)
      -> Gets category hot items.

    * api.get_featured_items(site_id, pool_id)
      -> Gets featured items.

    * api.get_site_trends(site_id, category_id)
      -> Gets site trends for category.

    * api.item_valid?(attribs)
      -> Checks if attributes are valid for creating an item.

    * api.create_item(attribs)
      -> Creates an item.

    * api.relist_item(item_id, price, quantity, listing_type_id)
      -> Relists an item.

    * api.update_item_fields(item_id, attribs)
      -> Updates item fields (price, stock, etc).

    * api.update_item_listing_type(item_id, listing_type_id)
      -> Updates item listing type.

    * api.add_item_description(item_id, text)
      -> Adds description to item.

##### Locations and currencies

    * api.get_countries
      -> Gets countries.

    * api.get_country(country_id)
      -> Gets country.

    * api.get_state(state_id)
      -> Gets state.

    * api.get_city(city_id)
      -> Gets city.

    * api.get_currencies
      -> Gets currencies

    * api.get_currency(currency_id)
      -> Gets currency info

    * api.currency_convertion_rate(currency_from, currency_to)
      -> Gets currency conversion rate

    * api.get_zip_code_info(country_id, zip_code)
      -> Gets zip code info

##### Order management

    * api.get_orders(filters={})
      -> Get all orders with filters (with pagination)

    * api.get_order(order_id)
      -> Gets order detail

    * api.get_order_feedbacks(order_id)
      -> Gets both seller and buyer feedbacks

    * api.get_buyer_feedback(order_id)
      -> Gets buyer feedback

    * api.get_seller_feedback(order_id)
      -> Gets seller feedback

    * api.give_feedback_to_order(order_id, feedback_data)
      -> Gives feedback to order

    * api.change_feedback_from_order(order_id, kind, feedback_data)
      -> Updates feedback from order. Kind is seller or buyer.

    * api.reply_feedback(order_id, kind, text)
      -> Reply a feedback. Kind is seller or buyer.

    * api.get_site_payment_methods(site_id)
      -> Get all payment methods from site.

    * api.get_order_blacklist(user_id)
      -> Get all users restricted to purchase you an item.

##### Questions

    * api.get_questions(filters={})
      -> Get all questions with filters (with pagination)

    * api.get_question(question_id)
      -> Gets question detail

    * api.delete_question(question_id)
      -> Deletes question

    * api.ask_question(item_id, text)
      -> Asks a question

    * api.answer_question(question_id, text)
      -> Answers a question

    * api.get_blacklisted_users_ids(seller_id)
      -> Get all blacklisted users

    * api.add_user_to_blacklist(seller_id, user_id)
      -> Adds user to blacklist

    * api.remove_user_from_blacklist(seller_id, user_id)
      -> Removes user from blacklist

##### Users

    * api.get_my_user
      -> Gets current user

    * api.get_user(user_id)
      -> Gets user detail

    * api.get_users(user_ids)
      -> Get all users with user_id from array

    * api.get_user_accepted_payment_methods(user_id)
      -> Get all accepted payment methods for the user.

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
