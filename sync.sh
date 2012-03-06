#!/bin/bash
git svn fetch kaltura.org
git checkout develop
git svn rebase
#git svn dcommit # uncomment to push back to svn
git checkout 1.6.9
git svn rebase
#git svn dcommit # uncomment to push back to svn
git checkout 1.6.8
git svn rebase
#git svn dcommit # uncomment to push back to svn
git checkout firefogg
git svn rebase
#git svn dcommit # uncomment to push back to svn
git checkout gh-pages
git svn rebase
#git svn dcommit # uncomment to push back to svn
git checkout kplayer-examples
git svn rebase
#git svn dcommit # uncomment to push back to svn
git checkout packager
git svn rebase
#git svn dcommit # uncomment to push back to svn

git push kaltura --all


# Finish up by checking out the git_svn_sync branch so sync.sh is still available for cronsa
git checkout git_svn_sync
