#!/bin/bash
# Author : Bing
# Script follows here:

# Define a function to load a web page using chromium browser
load_page() {
  # The first argument is the web page url
  url=$1
  # Open the url in a new tab of chromium browser
  chromium --new-tab $url --window-position=0,0 --window-size=700,500

}

# Generate a random UUID using /proc/sys/kernel/random/uuid
UUID=$(cat /proc/sys/kernel/random/uuid)

# Load the first web page with the random UUID
load_page "https://www.bing.com/turing/captcha/challenge?q=&iframeid=local-gen-$UUID"
