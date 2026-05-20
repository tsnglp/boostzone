# BoostZone

Professional Rails 8 website for BoostZone, an NSW-based IT services company serving businesses across Australia.

## Stack

- Ruby 3.4.5
- Rails 8.1.3
- PostgreSQL
- Tailwind CSS
- Stimulus + Importmap

## Pages

- `/` — Homepage
- `/services` — Services overview
- `/about` — Company profile
- `/contact` — Contact form

## Local setup

```bash
bundle install
bin/rails db:prepare
bin/dev
```

## Useful commands

```bash
bin/rails tailwindcss:build
bin/rails routes
bin/rubocop
```
