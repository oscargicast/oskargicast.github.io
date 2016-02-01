#!/bin/bash

echo -e "\033[0;32mDeploying updates to Github...\033[0m"

GITHUB_REPONAME="oskargicast/oskargicast.github.io"

# Build the project.
hugo

# Moving the generated project.
cp -R public /tmp
cp CNAME /tmp/public
cp README.md /tmp/public

# Going to "public" temporal project.
cd /tmp/public
git init

# Add changes to git.
git add -A

# Commit changes.
msg="[master] Rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Adding remote.
git remote add origin git@github.com:$GITHUB_REPONAME.git

# Push source and build repos.
git push origin master --force

# Deleting temporal project.
cd .. && rm -rf public
