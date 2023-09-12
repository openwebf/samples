# NextJS SSR Demo

This demo will show you how to use WebF with Next.js SSR support.

**1. Start your Next.js Dev Server**

```
cd next-app
npm run dev
```

This will start a development server at `http://localhost:3000`.

**2. Load your Next.js application in WebF**

Run this demo with Flutter 3.10.x.

open app/lib/main.dart

Change the URL in `WebFBundle.fromUrl()` to `http://localhost:3000` to load your Next.js app.