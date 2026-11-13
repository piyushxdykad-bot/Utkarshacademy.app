# Utkarsh Academy — web app

App-style site (landing + app hybrid) for Utkarsh Academy: Class 11, Class 12, CUET and Class 12 + CUET commerce coaching.

- Desktop: sidebar navigation · Mobile: top bar + bottom tab bar, bottom-sheet popups
- Hash routing (`/#class12-mocks`, `/#profile` …) with working back button, Ctrl+K search
- Backend: Supabase (auth, content, mocks/notes, results, sync) + Razorpay checkout via Supabase Edge Functions
- Content is published from the admin panel (`admin.html`, shares the same Supabase project)

Single file, no build step — serve `index.html` from any static host.


## Staff console

The admin panel is built into the app. Open **Staff login** in the footer (or the More menu, or `#staff`). It keeps its own sign-in session, separate from students, and access is still checked against the `admin_users` table.
