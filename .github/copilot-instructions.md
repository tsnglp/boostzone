# Copilot Instructions for BoostZone

BoostZone is a Rails 8.1 marketing website for an NSW-based IT services company. It is a **content-driven static site**: there are no database models, no user data, and no Active Record migrations for app data. All page content lives in Ruby, not a CMS or database.

## Stack

- Ruby 3.4.5, Rails 8.1.3
- PostgreSQL (used only by Solid Queue/Cache/Cable — there is no app schema)
- Tailwind CSS, Hotwire (Turbo + Stimulus), Importmap (no Node bundler)

## Commands

```bash
bin/dev                       # Run app + Tailwind watcher (uses Procfile.dev)
bin/rails db:prepare          # First-time setup
bin/rails tailwindcss:build   # Build CSS once
bin/rubocop                   # Lint (rubocop-rails-omakase house style)
bin/rubocop -a                # Auto-correct
bin/brakeman --no-pager       # Security scan
bin/bundler-audit             # Gem vulnerability scan
bin/importmap audit           # JS dependency scan
```

CI (`.github/workflows/ci.yml`) runs `brakeman`, `bundler-audit`, `importmap audit`, and `rubocop` on every PR. **There is no test suite and no test job** — there is no `test/` directory. Do not assume tests exist; if you add behavior worth testing, set up the test framework first.

## Architecture

- **Single controller drives everything.** `app/controllers/pages_controller.rb` serves all four pages (`home`, `services`, `about`, `contact`). A `before_action :set_page_content` populates instance variables (`@services`, `@benefits`, `@testimonials`, `@values`, etc.) consumed by the ERB views.
- **All site content is hardcoded Ruby data**, not a database. The canonical list of services is `services_catalog` (an array of hashes with `slug`, `title`, `summary`, `description`, `features`, `icon`). To add or edit a service, edit this method — not a model or seed file. `featured_services` selects a subset by `slug`.
- **The contact form does not persist or email anything.** `contact_submit` reads permitted params and renders a flash notice only. There is no mailer delivery or storage wired up.
- Routes are explicit `get`/`post` declarations in `config/routes.rb`, not RESTful resources.

## Conventions

- **Icons are inline SVGs from a Ruby registry**, not image assets. Use the `icon(name, classes:)` helper in `app/helpers/application_helper.rb`. Content hashes reference icons by symbol (e.g. `icon: :chatbot`); the symbol must exist as a key in the `icons` hash inside the helper. To add a new icon, add a key to that hash.
- **Theme colors are custom Tailwind tokens** defined in `tailwind.config.js`: `primary` (#1e3a5f), `accent` (#00b4d8), `dark` (#0f1e2e), `light` (#f0f4f8). Use these tokens (e.g. `bg-accent`, `text-primary`) rather than raw hex values.
- **Nav links use the `nav_link_to` helper**, which applies active/inactive styling via `current_page?`. Reuse it for navigation rather than bare `link_to`.
- Views are plain ERB templates in `app/views/pages/`; there are currently no shared partials.
- Australian/British English spelling is used throughout content ("optimisation", "modernise"). Match it.
- Stimulus controllers live in `app/javascript/controllers/` and are registered via importmap; follow the existing `mobile_menu_controller.js` pattern.

## Deployment

Containerised via the `Dockerfile` and deployed with Kamal (`config/deploy.yml`). Production uses `DATABASE_URL` for all Solid databases. Thruster fronts Puma for asset caching/compression.
