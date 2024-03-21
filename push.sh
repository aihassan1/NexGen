#!/usr/bin/env bash
# Git Automation Script
# Add all changes in the working directory to the staging area

git config --global user.email "abdosruor57@gmail.com"
git config --global user.name "aihassan1"

git add .
git commit -m "$*"
git push
