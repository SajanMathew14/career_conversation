# Career Conversation App

A virtual career assistant that answers questions about your professional background, skills, and experience. This application uses OpenAI's API to provide conversational responses based on your LinkedIn profile and personal summary.

## Overview

This application creates a chat interface where visitors can ask questions about your career, background, skills, and experience. The app responds as if it were you, using information from your LinkedIn profile and a personal summary. It can also collect contact information from interested users and record questions it couldn't answer.

## Features

- Conversational interface powered by OpenAI's GPT models
- Responds to questions about your career and background
- Collects contact information from interested users
- Records unanswered questions for future improvements
- Notification system using Pushover

## Prerequisites

Before you begin, you'll need:

1. **OpenAI API Key**: Sign up at [OpenAI](https://platform.openai.com/) to get your API key
2. **Pushover Account**: Sign up at [Pushover](https://pushover.net/) to get your user key and application token
3. **Hugging Face Account**: Sign up at [Hugging Face](https://huggingface.co/) to deploy your app
4. **Python 3.8+**: Required to run the application locally

## Local Setup

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/career-conversation-app.git
cd career-conversation-app
```

### 2. Install Dependencies

```bash
pip install -r requirements.txt
```

### 3. Create the .env File

Create a file named `.env` in the root directory of the project with the following content:

```
OPENAI_API_KEY=your_openai_api_key_here
PUSHOVER_USER=your_pushover_user_key_here
PUSHOVER_TOKEN=your_pushover_app_token_here
HF_TOKEN=your_huggingface_token_here
```

Replace the placeholder values with your actual API keys and tokens.

### 4. Prepare Your Personal Data

1. Create a directory named `me` in the root of the project
2. Add your LinkedIn profile as a PDF file named `linkedin.pdf` in the `me` directory
3. Create a text file named `summary.txt` in the `me` directory with a summary of your background and skills

### 5. Run the App Locally

```bash
python app.py
```

The app should now be running locally and accessible at http://localhost:7860

## Deploying to Hugging Face Spaces

### Step 1: Prepare Your Repository

Before deploying, make sure your repository is properly set up:

1. Ensure your `.env` file is listed in `.gitignore` to prevent exposing your API keys
2. Make sure you have a `requirements.txt` file with all necessary dependencies:

```
python-dotenv
openai
requests
pypdf
gradio
httpx
```

3. Run the `fix_deployment.sh` script to ensure your `.env` file is not tracked by git:

```bash
./fix_deployment.sh
```

### Step 2: Deploy to Hugging Face Spaces

#### Option 1: Using Gradio Deploy Command

1. Run the deployment command:
   ```bash
   gradio deploy
   ```
   
   If you're using uv (a Python package manager), you can run:
   ```bash
   uv run gradio deploy
   ```

2. When prompted, enter your Hugging Face token (this will not be stored in your code)

3. When asked "Add token as git credential?", answer "n" (no)

4. Enter the required metadata for your Space (title, app file, hardware)

5. When asked "Any Spaces secrets (y/n)", answer "y" (yes)

6. Add all the necessary secrets that your app uses:
   - OPENAI_API_KEY
   - PUSHOVER_USER
   - PUSHOVER_TOKEN

#### Option 2: Manual Deployment

If the `gradio deploy` command causes issues, you can try manual deployment:

1. Create a new Space on Hugging Face:
   - Go to [Hugging Face Spaces](https://huggingface.co/spaces)
   - Click "Create new Space"
   - Choose a name for your Space
   - Select "Gradio" as the SDK
   - Choose the appropriate hardware tier (CPU is sufficient for this app)
   - Click "Create Space"

2. Clone the Space repository locally:
   ```bash
   git clone https://huggingface.co/spaces/YOUR_USERNAME/YOUR_SPACE_NAME
   ```

3. Copy your app files to this repository (excluding the `.env` file):
   ```bash
   cp -r app.py requirements.txt me/ .hfignore .gitignore /path/to/cloned/space/
   ```

4. Add your secrets through the Hugging Face web interface:
   - Go to your Space settings
   - Navigate to the "Variables and Secrets" section
   - Click "New Secret"
   - Add each of these secrets:
     - OPENAI_API_KEY (the value from your local .env file)
     - PUSHOVER_USER (the value from your local .env file)
     - PUSHOVER_TOKEN (the value from your local .env file)

5. Commit and push your changes:
   ```bash
   git add .
   git commit -m "Initial commit"
   git push
   ```

### Step 3: Verify Your Deployment

1. After deployment, your app will be available at:
   ```
   https://huggingface.co/spaces/YOUR_USERNAME/YOUR_SPACE_NAME
   ```

2. Test your application by asking a few questions to ensure it's working correctly

## Troubleshooting Common Issues

### Missing Dependencies

If you encounter an error like:
```
ModuleNotFoundError: No module named 'openai'
```

Make sure your `requirements.txt` file includes all necessary dependencies and is properly included in your deployment.

### API Key Issues

If you encounter an error like:
```
openai.OpenAIError: The api_key client option must be set either by passing api_key to the client or by setting the OPENAI_API_KEY environment variable
```

This means your OpenAI API key is not properly set in the Hugging Face environment. Check that you've added the OPENAI_API_KEY secret in your Hugging Face Space settings.

### Secrets Detected in Files

If you encounter an error like:
```
BadRequestError: It appears that one or more of your files contain valid Hugging Face secrets
```

This means your `.env` file or other files containing API keys are being included in the deployment. Run the `fix_deployment.sh` script to fix this issue:

```bash
./fix_deployment.sh
```

### SSL Certificate Issues

If you encounter SSL certificate issues when running locally, the app includes code to disable SSL verification for development purposes. However, this should be removed in a production environment.

## Security Considerations

- Never commit API keys, tokens, or other secrets to public repositories
- Always use environment variables or secrets management for sensitive information
- Regularly rotate your API keys and tokens for better security
- Consider implementing rate limiting to prevent abuse of your OpenAI API key

## License

MIT license

## Contact

[Your contact information]
