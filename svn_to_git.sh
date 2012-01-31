#!/bin/bash

## This script checks out all branches, tags, and trunk from http://www.kaltura.org/ , then it sets up some sane tracking branches

## GIT Notes

## Creating Branches on Kaltura.org
# create a branch on the kalorg svn repo with:
#     git svn branch new_branch_name -m 'adding new branch' -d html5video/branches
# checkout a local working branch to track the remote branch
#     git checkout --track -b new_branch_name remotes/kaltura.org/new_branch_name
# commit to your local working branch and then commit to kalorg svn with
#     git svn dcommit

# TODO: if .git exists, do git-svn fetch, otherwise exit

## Setup Git

git init
git config svn.authorsfile authors.txt
git config svn.rmdir true

## Setup Git SVN

git svn init http://www.kaltura.org/kalorg/html5video/ --svn-remote=kaltura.org --prefix=kaltura.org/ --trunk=trunk/mwEmbed --branches=branches --tags=tags --branches=trunk ;

## Turn on this to track mediawiki.org TimedMediaHandler
# Doesn't work: git svn init svn+ssh://svn.wikimedia.org/svnroot/mediawiki/ --svn-remote=TimedMediaHandler --prefix=TimedMediaHandler/ --trunk=trunk/extensions/TimedMediaHandler --branches=branches/MwEmbedStandAloneRL1_17/MwEmbedStandAlone mwEmbed.git_sync;
# we're missing a number of authors from authors.txt, so this fails
#git svn init svn+ssh://svn.wikimedia.org/svnroot/mediawiki/ --svn-remote=mediawiki.org --prefix=mediawiki.org/ --trunk=trunk/extensions/TimedMediaHandler;
## and add the following to the repo fetch stage:
#git svn fetch mediawiki.org

echo "Git Config:"
cat .git/config

## Fetch Entire Repository (this takes a long time)

echo "Fetching from svn:"
git svn fetch kaltura.org
git branch --set-upstream master remotes/kaltura.org/trunk
git svn merge kaltura.org

#echo "Master Branch"
ls -alh

## Branch Tracking

#echo "Setting up some tracking branches."
git branch --track packager remotes/kaltura.org/packager
git branch --track gh-pages remotes/kaltura.org/docs
git branch --track firefogg remotes/kaltura.org/firefogg
git branch --track kplayer-examples remotes/kaltura.org/kplayer-examples
git branch --track git_svn_sync remotes/kaltura.org/git_svn_sync

# correct a couple of mistakes
git branch -rd kaltura.org/new_branch_name
git branch -rd kaltura.org/svn_to_git
rm -rf .git/svn/refs/remotes/kaltura.org/svn_to_git/
rm -rf .git/svn/refs/remotes/kaltura.org/new_branch_name/
git gc --prune=all

#echo "Local Branches"
git branch

#echo "Remote Branches"
git branch -r

## Check the output to make sure it's sane.
echo "Git Config:"
cat .git/config
git status

#echo "attempting to maks evn_to_git branch"
#git svn branch new_branch_name -m 'adding new branch' -d html5video/branches
# checkout a local working branch to track the remote branch
#     git checkout --track -b new_branch_name remotes/kaltura.org/new_branch_name
# commit to your local working branch and then commit to kalorg svn with
