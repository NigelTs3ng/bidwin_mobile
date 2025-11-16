#!/bin/bash

echo "🚀 Deploying BidWin to Vercel..."
echo ""

# Check if build exists
if [ ! -d "build/web" ]; then
    echo "❌ Build not found. Building now..."
    flutter build web --release
fi

# Ensure vercel.json is in build/web
if [ ! -f "build/web/vercel.json" ]; then
    echo "📋 Creating vercel.json in build/web..."
    cat > build/web/vercel.json << 'EOF'
{
  "rewrites": [
    {
      "source": "/(.*)",
      "destination": "/index.html"
    }
  ]
}
EOF
fi

# Check if vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "❌ Vercel CLI not found. Installing..."
    npm install -g vercel
fi

echo "📦 Deploying build/web to Vercel..."
echo ""

cd build/web
vercel --prod

echo ""
echo "✅ Deployment complete!"
echo "📱 Open the URL on your iPhone Safari to test!"

