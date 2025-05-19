# Deployment Guide for Career Conversation App

This guide explains how to safely deploy your Career Conversation app to Hugging Face Spaces without exposing sensitive API keys and tokens.

## Preparing for Deployment

1. Make sure your `.env` file is listed in `.gitignore` (already done)
2. Ensure you're not committing any files containing sensitive information

## Deploying to Hugging Face Spaces

### Method 1: Using `gradio deploy` Command

1. Run the deployment command:
   ```bash
   gradio deploy
   ```

2. When prompted, enter your Hugging Face token (this will not be stored in your code)

3. When asked "Add token as git credential?", answer "n" (no)

4. Enter the required metadata for your Space (title, app file, hardware)

5. When asked "Any Spaces secrets (y/n)", answer "y" (yes)

6. Add all the necessary secrets that your app uses:
   - OPENAI_API_KEY
   - PUSHOVER_USER
   - PUSHOVER_TOKEN
   - Any other API keys your app needs

7. Complete the deployment process

### Method 2: Manual Deployment

If the `gradio deploy` command continues to cause issues, you can try manual deployment:

1. Create a new Space on Hugging Face (https://huggingface.co/spaces)

2. Clone the Space repository locally:
   ```bash
   git clone https://huggingface.co/spaces/YOUR_USERNAME/YOUR_SPACE_NAME
   ```

3. Copy your app files to this repository (excluding the `.env` file)

4. Add your secrets through the Hugging Face web interface:
   - Go to your Space settings
   - Navigate to the "Variables and Secrets" section
   - Add all required secrets

5. Commit and push your changes:
   ```bash
   git add .
   git commit -m "Initial commit"
   git push
   ```

## Troubleshooting

If you encounter the error about secrets being detected in your files:

1. Make sure the `.env` file is not being tracked by git:
   ```bash
   git rm --cached .env
   ```

2. Check if any other files might contain API keys or tokens

3. Commit the changes:
   ```bash
   git commit -m "Remove sensitive files from tracking"
   ```

4. Try deploying again

## Important Security Notes

- Never commit API keys, tokens, or other secrets to public repositories
- Always use environment variables or secrets management for sensitive information
- Regularly rotate your API keys and tokens for better security
