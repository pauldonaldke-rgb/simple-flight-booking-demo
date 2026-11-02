# Simple Flight Booking Demo

A static, browser-based flight search demo with optional shared search storage
through Supabase.

## Run locally

Open `index.html` in a modern browser. Without Supabase configuration, search
history stays in that browser's IndexedDB. Simulated booking records stay in
that browser's local storage.

## Configure the shared Supabase database

1. Create a Supabase project.
2. In the Supabase SQL Editor, run [`database/schema.sql`](database/schema.sql).
   It creates `public.flight_searches`, enables row-level security, and permits
   anonymous clients to insert valid searches only. Anonymous users cannot read,
   update, or delete records.
3. Copy the project's URL and its **publishable/anon key** into
   [`supabase-config.js`](supabase-config.js):

   ```js
   window.SUPABASE_CONFIG = {
     url: "https://YOUR-PROJECT.supabase.co",
     anonKey: "YOUR-PUBLISHABLE-OR-ANON-KEY"
   };
   ```

4. Commit and push the updated config, then wait for the GitHub Pages deployment.
   The deployed site's origin must be allowed in the Supabase API CORS settings.
5. To view saved searches, sign in to Supabase and use **Table Editor →
   flight_searches**. The public website intentionally has no endpoint for
   reading customer searches.

The browser key is public by design. Never put a Supabase `service_role` key,
database password, or other secret in this repository or frontend.

The form saves only origin, destination, departure date, traveler count, and
creation time, after the visitor checks the consent box. It does not submit
names, contact details, passport information, or payment data. Search history
shown on the page is browser-local, even when a shared Supabase insert succeeds.
Clearing browser history does not delete Supabase records; manage shared records
in the Supabase dashboard.

Before using this for real customers, add abuse/rate protection (for example a
server-side function and CAPTCHA), publish an appropriate privacy notice and
retention policy, and review applicable data-protection requirements. Do not
use demo flight data to confirm or sell real fares.

## Deployment

Before the first deployment, open the repository's **Settings → Pages** and set
the build and deployment source to **GitHub Actions**. The repository owner must
enable this once; the workflow cannot change that repository setting. Afterward,
GitHub Actions deploys the static site whenever `main` changes. You can also run
the workflow manually from the **Actions** tab.
