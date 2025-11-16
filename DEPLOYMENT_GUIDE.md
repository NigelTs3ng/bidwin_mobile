# BidWin Mobile - Deployment Guide

## Running on iPhone During Development

### Prerequisites

1. **Install Xcode** (if not already installed):
   ```bash
   # Install from App Store or download from developer.apple.com
   # Then run:
   sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
   sudo xcodebuild -runFirstLaunch
   ```

2. **Connect your iPhone**:
   - Connect iPhone to Mac via USB cable
   - Unlock your iPhone
   - Trust the computer if prompted

3. **Enable Developer Mode on iPhone**:
   - Go to Settings > Privacy & Security > Developer Mode
   - Enable Developer Mode
   - Restart iPhone if prompted

4. **Trust your Mac on iPhone**:
   - When you first connect, iPhone will ask to "Trust This Computer"
   - Tap "Trust" and enter your passcode

### Running the App

1. **Check connected devices**:
   ```bash
   flutter devices
   ```
   Your iPhone should appear in the list (e.g., "iPhone 15 Pro")

2. **Run on iPhone**:
   ```bash
   flutter run -d <device-id>
   ```
   Or simply:
   ```bash
   flutter run
   ```
   (Flutter will prompt you to select the device)

3. **First-time setup**:
   - Xcode will ask you to sign the app
   - Select your Apple ID (free account works for development)
   - Xcode will automatically create a provisioning profile

### Troubleshooting iOS Setup

If you see signing errors:
1. Open the project in Xcode:
   ```bash
   open ios/Runner.xcworkspace
   ```
2. Select the Runner project in the left sidebar
3. Go to "Signing & Capabilities" tab
4. Select your Team (your Apple ID)
5. Xcode will automatically manage signing

---

## Deploying to Web (Accessible via URL on iPhone)

Flutter can build web apps that run in Safari on your iPhone! Here's how:

### Option 1: Build for Web Locally

1. **Build the web app**:
   ```bash
   flutter build web
   ```
   This creates a `build/web` folder with all the files.

2. **Test locally**:
   ```bash
   flutter run -d chrome
   ```

3. **Deploy to a hosting service** (see options below)

### Option 2: Deploy to Firebase Hosting (Recommended - Free)

1. **Install Firebase CLI**:
   ```bash
   npm install -g firebase-tools
   ```

2. **Login to Firebase**:
   ```bash
   firebase login
   ```

3. **Initialize Firebase in your project**:
   ```bash
   cd bidwin_mobile
   firebase init hosting
   ```
   - Select "Use an existing project" or create a new one
   - Set public directory to: `build/web`
   - Configure as single-page app: **Yes**
   - Don't overwrite index.html: **No**

4. **Build and deploy**:
   ```bash
   flutter build web --release
   firebase deploy --only hosting
   ```

5. **Access your app**:
   - Firebase will give you a URL like: `https://your-project.web.app`
   - Open this URL on your iPhone Safari!

### Option 3: Deploy to Vercel (Free & Easy)

1. **Install Vercel CLI**:
   ```bash
   npm install -g vercel
   ```

2. **Build the web app**:
   ```bash
   flutter build web --release
   ```

3. **Deploy**:
   ```bash
   cd build/web
   vercel
   ```
   Follow the prompts. Vercel will give you a URL!

### Option 4: Deploy to GitHub Pages (Free)

1. **Build the web app**:
   ```bash
   flutter build web --release --base-href "/bidwin_mobile/"
   ```

2. **Create a GitHub Actions workflow** (create `.github/workflows/deploy.yml`):
   ```yaml
   name: Deploy to GitHub Pages
   
   on:
     push:
       branches: [ main ]
   
   jobs:
     deploy:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v3
         - uses: subosito/flutter-action@v2
           with:
             flutter-version: '3.35.7'
         - run: flutter pub get
         - run: flutter build web --release --base-href "/bidwin_mobile/"
         - uses: peaceiris/actions-gh-pages@v3
           with:
             github_token: ${{ secrets.GITHUB_TOKEN }}
             publish_dir: ./build/web
   ```

3. **Enable GitHub Pages**:
   - Go to your repo Settings > Pages
   - Select source: "GitHub Actions"
   - Your app will be at: `https://yourusername.github.io/bidwin_mobile/`

### Option 5: Deploy to Netlify (Free)

1. **Build the web app**:
   ```bash
   flutter build web --release
   ```

2. **Drag and drop** the `build/web` folder to [Netlify Drop](https://app.netlify.com/drop)

3. **Or use Netlify CLI**:
   ```bash
   npm install -g netlify-cli
   netlify deploy --prod --dir=build/web
   ```

---

## Quick Commands Reference

### iOS Development
```bash
# List devices
flutter devices

# Run on connected iPhone
flutter run -d <device-id>

# Build iOS app
flutter build ios --release
```

### Web Deployment
```bash
# Build for web
flutter build web --release

# Test web build locally
flutter run -d chrome

# Deploy to Firebase
firebase deploy --only hosting

# Deploy to Vercel
cd build/web && vercel
```

---

## Notes

- **Web Performance**: Flutter web apps work great on mobile Safari! The app will be responsive and feel native.
- **PWA Support**: Flutter web apps can be installed as Progressive Web Apps (PWAs) on iPhone, allowing users to add it to their home screen.
- **Free Hosting**: All options above (Firebase, Vercel, GitHub Pages, Netlify) offer free tiers perfect for development and testing.
- **Custom Domain**: Most hosting services allow you to add a custom domain later.

---

## Recommended Workflow

1. **Development**: Use `flutter run -d chrome` for quick iteration
2. **Testing on iPhone**: Use `flutter run` with iPhone connected for native testing
3. **Staging**: Deploy to Firebase/Vercel for testing on real devices via URL
4. **Production**: Use the same hosting service with a custom domain

