#!/bin/bash

# miiwiichat Railway Deployment Helper Script
# This script helps you prepare and deploy to Railway

set -e

echo "🚀 miiwiichat Railway Deployment Helper"
echo "========================================"
echo ""

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "📦 Initializing Git repository..."
    git init
    echo "✅ Git initialized"
else
    echo "✅ Git already initialized"
fi

# Check if remote exists
if git remote | grep -q "origin"; then
    echo "✅ Git remote 'origin' exists"
    REPO_URL=$(git remote get-url origin)
    echo "   Current origin: $REPO_URL"
else
    echo ""
    echo "❌ No git remote 'origin' found"
    echo ""
    echo "Please create a GitHub repository and add it as remote:"
    echo ""
    echo "1. Go to https://github.com/new"
    echo "2. Create a new repository (e.g., 'miiwiichat')"
    echo "3. Run: git remote add origin https://github.com/YOUR_USERNAME/miiwiichat.git"
    echo ""
    read -p "Press Enter after adding remote, or Ctrl+C to exit..."
fi

# Add all files
echo ""
echo "📝 Adding files to git..."
git add .

# Check for changes
if git diff-index --quiet HEAD --; then
    echo "✅ No new changes to commit"
else
    echo "💾 Committing changes..."
    git commit -m "Prepare for Railway deployment"
    echo "✅ Changes committed"
fi

# Push to GitHub
echo ""
echo "📤 Pushing to GitHub..."
BRANCH=$(git branch --show-current)
git push -u origin $BRANCH

echo ""
echo "✅ Code pushed to GitHub!"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 Next Steps:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "1. Go to https://railway.app"
echo "2. Click 'New Project' → 'Deploy from GitHub repo'"
echo "3. Select your miiwiichat repository"
echo "4. Add MongoDB database (+ New → Database → MongoDB)"
echo "5. Configure environment variables (see DEPLOYMENT_STEPS.md)"
echo ""
echo "📖 Full guide: DEPLOYMENT_STEPS.md"
echo "📖 Documentation: README.md"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎯 Quick Environment Variables Reference:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Backend Service:"
echo "  MONGO_URL=<from Railway MongoDB service>"
echo "  DB_NAME=miiwiichat"
echo "  CORS_ORIGINS=*"
echo "  JWT_SECRET=<generate-random-secret>"
echo "  PORT=8001"
echo ""
echo "Frontend Service:"
echo "  REACT_APP_BACKEND_URL=<your-backend-railway-url>"
echo "  PORT=3000"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "✨ Happy deploying! Your Discord clone will be live soon!"
echo ""
