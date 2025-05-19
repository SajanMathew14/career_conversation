#!/bin/bash

# This script helps fix the deployment issue by removing the .env file from git tracking
# without deleting the actual file, and then setting up proper gitignore

echo "Starting deployment fix..."

# Check if .gitignore exists
if [ ! -f .gitignore ]; then
  echo "Creating .gitignore file..."
  echo ".env" > .gitignore
  echo ".DS_Store" >> .gitignore
  echo "__pycache__/" >> .gitignore
  echo "*.pyc" >> .gitignore
else
  echo ".gitignore already exists."
  # Make sure .env is in .gitignore
  if ! grep -q "^\.env$" .gitignore; then
    echo "Adding .env to .gitignore..."
    echo ".env" >> .gitignore
  else
    echo ".env is already in .gitignore."
  fi
fi

# Initialize git if not already initialized
if [ ! -d .git ]; then
  echo "Initializing git repository..."
  git init
fi

# Remove .env from git tracking without deleting the file
echo "Removing .env from git tracking (without deleting the file)..."
git rm --cached .env 2>/dev/null || echo ".env is not tracked by git."

# Commit the changes
echo "Committing changes..."
git add .gitignore .hfignore
git commit -m "Remove .env from git tracking and update ignore files"

echo ""
echo "Fix completed! Now you can try deploying again with:"
echo "gradio deploy"
echo ""
echo "Remember to add your secrets through the Hugging Face Spaces interface when prompted."
echo "DO NOT add the .env file to your deployment."
