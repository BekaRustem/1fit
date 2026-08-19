# 💪 Restart — Gym Streak & Progress Tracker

A tiny, fast workout tracker that lives on your iPhone home screen. Tick off your gym streak, log the weight you use on every exercise, and watch your strength climb over days, weeks, and months.

**Live app → [amjadhajireen.github.io/gym-tracker](https://amjadhajireen.github.io/gym-tracker/)**

No app store, no account, no backend. One self-contained HTML file that installs as a Progressive Web App and works fully offline.

---

## Features

- **Streak tracking** — counts only your scheduled training days; rest days never break the chain. Current streak, longest streak, and a month calendar at a glance.
- **Per-exercise logging** — one row per exercise: type the weight and the reps. A single number applies to every set; tap the `,` key when a set differs (`60, 60, 55`). Last session's numbers show as placeholders.
- **Progress charts** — a line graph of your best set over time for every exercise, with latest / personal-best / gain-since-start.
- **Personal records** — PR badges surface as you beat them.
- **Weekly split** — a structured program with strength, hypertrophy, and recovery days baked in.
- **Backup & restore** — export your history to a JSON file and import it back any time. Your data lives only on your device.

## Install on iPhone

1. Open the [live app](https://amjadhajireen.github.io/gym-tracker/) in **Safari**.
2. Tap **Share** → **Add to Home Screen** → **Add**.
3. Launch it from the new icon — it opens fullscreen and works offline.

> Works on Android too: open in Chrome → menu → *Add to Home screen*.

## Privacy

All workout data is stored locally in your browser (`localStorage`) on your own device. Nothing is uploaded, tracked, or sent anywhere — there is no server. The only way data leaves your phone is if *you* export a backup file.

## Tech

- Single static `index.html` — vanilla JavaScript, no dependencies, no build step.
- Data persistence via `localStorage`.
- PWA via Apple touch-icon + web-app meta tags; offline-capable once loaded.
- Home-screen icon generated at build time by `gen.py` (Python standard library only — no third-party packages).

## Develop

The app is built from `app_template.html` with an embedded icon:

```bash
python3 gen.py   # injects the generated icon → writes index.html
```

Edit `app_template.html` (or the program definition inside it), re-run `gen.py`, and push — GitHub Pages redeploys automatically. Existing logged history is untouched by updates.

## License

MIT — personal project, use it however you like.
