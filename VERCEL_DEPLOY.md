# Deploying BidWin to Vercel

## ✅ Build Status: Ready for Deployment

The web build has been tested and is ready. The app is optimized for iPhone Safari with:
- ✅ Mobile viewport configuration
- ✅ PWA support (can be added to home screen)
- ✅ Responsive design
- ✅ Touch-optimized UI
- ✅ Proper caching headers

## Option 1: Deploy Pre-built Files (Recommended - Easiest)

Since Vercel doesn't have Flutter installed by default, the easiest approach is to build locally and deploy the output:

### Steps:

1. **Build the web app locally** (already done):
   ```bash
   flutter build web --release
   ```

2. **Install Vercel CLI** (if not already installed):
   ```bash
   npm install -g vercel
   ```

3. **Deploy the build folder**:
   ```bash
   cd build/web
   vercel
   ```
   
   Or deploy from project root:
   ```bash
   vercel --cwd build/web
   ```

4. **Follow the prompts**:
   - Link to existing project or create new
   - Confirm settings
   - Vercel will give you a URL!

### For Production Deployment:
```bash
cd build/web
vercel --prod
```

---

## Option 2: Deploy with Vercel Build (Advanced)

If you want Vercel to build automatically on each push, you'll need to set up Flutter in the build environment.

### Update `vercel.json`:

The current `vercel.json` is configured, but Vercel needs Flutter installed. You have two sub-options:

#### 2A: Use Vercel's Build Settings (Manual Setup)

1. Go to your Vercel project settings
2. Under "Build & Development Settings":
   - Framework Preset: **Other**
   - Build Command: `flutter pub get && flutter build web --release`
   - Output Directory: `build/web`
   - Install Command: (leave empty or use a custom script)

3. Add Environment Variable (if needed):
   - Add a build script that installs Flutter first

#### 2B: Use GitHub Actions + Vercel (Best for CI/CD)

Create `.github/workflows/deploy-vercel.yml`:

```yaml
name: Build and Deploy to Vercel

on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.35.7'
          channel: 'stable'
      
      - name: Install dependencies
        run: flutter pub get
      
      - name: Build web
        run: flutter build web --release
      
      - name: Deploy to Vercel
        uses: amondnet/vercel-action@v25
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          working-directory: ./build/web
```

Then:
1. Get your Vercel tokens from vercel.com/account/tokens
2. Add them as GitHub Secrets
3. Push to trigger deployment

---

## Option 3: Manual Upload via Vercel Dashboard

1. Build locally: `flutter build web --release`
2. Go to vercel.com
3. Create new project
4. Drag and drop the `build/web` folder
5. Deploy!

---

## Testing on iPhone

Once deployed:

1. **Open the Vercel URL on iPhone Safari**
2. **Test the app** - it should work perfectly with:
   - Vertical scrolling feed
   - Horizontal swipe to activity screen
   - Touch interactions
   - Responsive sizing

3. **Add to Home Screen** (PWA):
   - Tap the Share button in Safari
   - Select "Add to Home Screen"
   - The app will launch like a native app!

---

## Current Build Output

✅ Build location: `build/web/`
✅ Files included:
   - `index.html` (optimized for mobile)
   - `main.dart.js` (compiled Flutter app)
   - `assets/` (images, fonts)
   - `manifest.json` (PWA config)
   - All required Flutter web files

---

## Troubleshooting

### If build fails on Vercel:
- Use Option 1 (pre-built deployment) - it's the most reliable
- Or ensure Flutter is installed in Vercel's build environment

### If app doesn't load on iPhone:
- Check that all routes redirect to `index.html` (configured in `vercel.json`)
- Verify HTTPS is enabled (Vercel does this automatically)
- Clear Safari cache and reload

### Performance Tips:
- The build includes tree-shaking (removed unused icons - 99%+ reduction)
- Assets are cached with proper headers
- First load might take a few seconds, then it's fast

---

## Quick Deploy Command

For the fastest deployment right now:

```bash
cd build/web && vercel --prod
```

That's it! 🚀

