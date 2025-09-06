#!/bin/bash

# Git commands to push plotR to GitHub

echo "🚀 Pushing plotR package to GitHub..."

# Initialize git repository (if not already done)
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial release: plotR v1.0.0 - Interactive data visualization with Observable Plot

✨ Features:
• 10 chart types including scatter, bar, line, pie, donut, stacked dots, bubble maps
• Interactive tooltips with emoji support
• Professional styling and responsive design  
• Grammar of graphics approach
• Observable Plot JavaScript library integration
• Comprehensive documentation and examples

🎯 All charts include hover tooltips and are ready for production use!"

# Add remote origin
git remote add origin https://github.com/ashgreat/plotR.git

# Push to GitHub
git branch -M main
git push -u origin main

echo "✅ Successfully pushed to GitHub!"
echo "🌐 Repository: https://github.com/ashgreat/plotR"
echo ""
echo "📋 Next steps:"
echo "1. Take screenshots of examples/ HTML files"
echo "2. Add screenshots to screenshots/ folder"
echo "3. Create first release on GitHub"
echo "4. Set up GitHub Pages (optional)"

