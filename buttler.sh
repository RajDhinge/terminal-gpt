#!/bin/bash

# Set variables for API request
API_ENDPOINT='https://chateverywhere.app/api/chat'
MODEL_ID='gpt-3.5-turbo-0613'
MODEL_NAME='GPT-3.5'
MAX_LENGTH=12000
TOKEN_LIMIT=4000
COMPLETION_TOKEN_LIMIT=800
PROMPT='your output shall be relevant shell command to the input only if you find shell command output shall have Complete else Fail code'
TEMPERATURE=0.5

# Set headers for API request
HEADERS=(
  'Content-Type: application/json'
  'Accept-Language: en-IN,en-GB;q=0.9,en;q=0.8'
  'User-Browser-ID: '
  'User-Selected-Plugin-ID: '
  'User-Token: '
  'Output-Language: '
)

# Check if the command line argument is provided
if [ -z "$1" ]; then
  echo "Please provide a message as a command line argument."
  exit 1
fi

# Get message content from command line argument
CONTENT="$1"

# Send message to Chat Everywhere API
CURL_OUTPUT=$(curl -s "$API_ENDPOINT" \
  -X 'POST' \
  -H "${HEADERS[@]}" \
  --data-raw '{
    "model": {
      "id": "'"$MODEL_ID"'",
      "name": "'"$MODEL_NAME"'",
      "maxLength": '"$MAX_LENGTH"',
      "tokenLimit": '"$TOKEN_LIMIT"',
      "completionTokenLimit": '"$COMPLETION_TOKEN_LIMIT"'
    },
    "messages": [
      {
        "pluginId": null,
        "role": "user",
        "content": "'"$CONTENT"'"
      }
    ],
    "prompt": "'"$PROMPT"'",
    "temperature": '"$TEMPERATURE"'
  }')

# Check if API request was successful
if [ $? -ne 0 ]; then
  # Print API response
	echo -e "\033[32m$CURL_OUTPUT\033[0m"
fi
