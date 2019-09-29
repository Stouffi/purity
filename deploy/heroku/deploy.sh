#!/bin/sh
# pwd
heroku git:remote -a stouffi
git stash
bower i
pulp build
cp -f deploy/heroku/gitignore .gitignore
cp -f deploy/heroku/Procfile Procfile
cp -f deploy/heroku/package.json package.json
cp deploy/heroku/index.js output
git add -A
git commit -m "deploy"
git push heroku master
git reset --hard HEAD^
git stash pop
