# Jungle

Jungle is a small e-commerce application that allows users and visitors to browse, shop and make an orders in their cart. Users can review products and administrator are able to create new categories and products.

Jungle is a full stack web application built with Ruby on Rails v4.2 and PostgreSQL.

!["Screenshot of Jungle"](https://github.com/eddycheong/jungle-rails/blob/master/docs/jungle.gif)
!["Screenshot of Jungle as Admin"](https://github.com/eddycheong/jungle-rails/blob/master/docs/admin.gif)

## Getting Started

1. Git clone this repository
2. Run `bundle install` to install dependencies
3. Create `config/database.yml` by copying `config/database.example.yml`
4. Create `config/secrets.yml` by copying `config/secrets.example.yml`
5. Run `bin/rake db:reset` to create, load and seed db
4. Create `.env` by copying `.env.example`
7. Sign up for a Stripe account
8. Put Stripe (test) keys into appropriate .env vars
9. Run `bin/rails s -b 0.0.0.0` to start the server

## Stripe Testing

Use Credit Card # 4111 1111 1111 1111 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

* Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
* PostgreSQL 9.x
* Stripe
