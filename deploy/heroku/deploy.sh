#!/bin/sh
heroku git:remote -a stouffi
git co -b deploy
pulp build
