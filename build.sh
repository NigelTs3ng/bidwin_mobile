#!/bin/bash
set -e

echo "🔨 Building BidWin for web..."

# Get Flutter dependencies
flutter pub get

# Build for web with optimizations
flutter build web --release

echo "✅ Build complete! Output in build/web/"

