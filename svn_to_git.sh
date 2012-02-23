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

## Branch Tracking TODO Check to see that git-svn fetch is up to date

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
git reset --hard HEAD

## Setup release branch tracking
git branch --track 1.3 remotes/kaltura.org/tags/dragonfly_v1.3a
git branch --track 1.5 remotes/kaltura.org/tags/1.5
git branch --track 1.6.0 remotes/kaltura.org/tags/1.6.0
git branch --track 1.6.1 remotes/kaltura.org/tags/1.6.1
git branch --track 1.6.2 remotes/kaltura.org/tags/1.6.2
git branch --track 1.6.3 remotes/kaltura.org/tags/1.6.3

## Setup new tracking repos for tagged releases with mwEmbed folders
git svn init http://www.kaltura.org/kalorg/html5video/ --svn-remote=svn-1.6.4 --prefix=svn-1.6.4/ --trunk=tags/1.6.4/mwEmbed ;
git svn init http://www.kaltura.org/kalorg/html5video/ --svn-remote=svn-1.6.5 --prefix=svn-1.6.5/ --trunk=tags/1.6.5/mwEmbed ;
git svn init http://www.kaltura.org/kalorg/html5video/ --svn-remote=svn-1.6.6 --prefix=svn-1.6.6/ --trunk=tags/1.6.6/mwEmbed ;
git svn init http://www.kaltura.org/kalorg/html5video/ --svn-remote=svn-1.6.7 --prefix=svn-1.6.7/ --trunk=tags/1.6.7/mwEmbed ;
git svn init http://www.kaltura.org/kalorg/html5video/ --svn-remote=svn-1.6.8 --prefix=svn-1.6.8/ --trunk=tags/1.6.8/mwEmbed ;
git svn init http://www.kaltura.org/kalorg/html5video/ --svn-remote=svn-1.6.9 --prefix=svn-1.6.9/ --trunk=tags/1.6.9/mwEmbed ;

git svn fetch svn-1.6.4
git svn fetch svn-1.6.5
git svn fetch svn-1.6.6
git svn fetch svn-1.6.7
git svn fetch svn-1.6.8
git svn fetch svn-1.6.9

git branch --track 1.6.4 svn-1.6.4/trunk
git branch --track 1.6.5 svn-1.6.5/trunk
git branch --track 1.6.6 svn-1.6.6/trunk
git branch --track 1.6.7 svn-1.6.7/trunk
git branch --track 1.6.8 svn-1.6.8/trunk
git branch --track 1.6.9 svn-1.6.9/trunk

#echo "Local Branches"
git branch

#echo "Remote Branches"
git branch -r

## Check the output to make sure it's sane.
echo "Git Config:"
cat .git/config
git status

#echo "attempting to maks svn_to_git branch"
## TODO checkout unique branch
git checkout -b git_svn_sync_latest
git add authors.txt
git add svn_to_git.sh
git commit -m 'latest svn_to_git and authors added'
#git checkout git_svn_sync
#git merge git_svn_sync_latest
#git branch -D git_svn_sync_latest
#git svn dcommit
