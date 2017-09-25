#!/bin/bash -eu

git fetch upstream
git checkout master
git merge upstream/master
