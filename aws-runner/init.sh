#! /bin/bash
# Create a folder
mkdir actions-runner && cd actions-runner
 # Download the latest runner package
curl -o actions-runner-linux-x64-2.316.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.316.1/actions-runner-linux-x64-2.316.1.tar.gz
# Optional: Validate the hash
echo "d62de2400eeeacd195db91e2ff011bfb646cd5d85545e81d8f78c436183e09a8  actions-runner-linux-x64-2.316.1.tar.gz" | shasum -a 256 -c
# Extract the installer
tar xzf ./actions-runner-linux-x64-2.316.1.tar.gz


# Create the runner and start the configuration experience
./config.sh --url https://github.com/swapnilakolkar1/next-project1-backend --token AES245XRJMTWMIULK6YGVTTGLCA7E --name "aws-runner" --unattended
# Last step, run it!
 ./run.sh

# Use this YAML in your workflow file for each job
# runs-on: self-hosted
