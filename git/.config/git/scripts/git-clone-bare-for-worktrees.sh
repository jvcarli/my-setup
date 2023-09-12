#!/usr/bin/env bash

# Usage:
#   $ git-clone-bare-for-worktrees git@github.com:name/repo.git
#
#   => Clones to a repo.git/.git directory
#   => Creates repo.git/worktrees directory
#   => Creates repo.git/resources directory
#
#   $ git-clone-bare-for-worktrees git@github.com:name/repo.git my-repo
#
#   => Clones to a my-repo/.git directory
#   => Creates my-repo.git/worktrees directory
#   => Creates my-repo.git/resources directory

# TODO: optionally accepts upstream repo as argument
# TODO: if there's a main (or master) branch repo on origin add it as a worktree

# Inspired from:
#   see: https://morgan.cugerone.com/blog/how-to-use-git-worktree-and-in-a-clean-way/
#   see: https://morgan.cugerone.com/blog/workarounds-to-git-worktree-using-bare-repository-and-cannot-fetch-remote-branches/
#   see: https://levelup.gitconnected.com/git-worktrees-the-best-git-feature-youve-never-heard-of-9cd21df67baf

# Plan is to create worktrees as siblings of $git_dir directory.
# Example targeted structure:
#
# <my-project>
# ├── .git/      (bare repository)
# ├── worktrees/ (all project git worktrees)
# │   ├── main/
# │   ├── new-awesome-feature/
# │   ├── hot-fix-62/
# │   └── ...
# └── resources/ (all project resources that I DON'T want to be tracked by git)
#     ├── some-doc.pdf
#     ├── some-image.jpg
#     ├── can-be-repos-too/
#     └── ...

set -e

# if its variable $1 .. $n you need write to
# a regular variable to use the substitution
url=$1

# Define git directory
if [ "$2" != "" ]; then
    # $2 was given
    repo_dir=$2
    git_dir=$repo_dir/.git
else
    # $2 was not given
    # if url ends on .git cleans it so it won't get duplicated when defining $repo_dir
    basename=${url##*/}
    repo_dir=${basename%.*}

    git_dir=$repo_dir/.git
fi

git clone --bare "$url" "$git_dir"

# Explicitly sets the remote origin fetch so we can fetch remote branches
# see: https://github.com/ThePrimeagen/git-worktree.nvim#troubleshooting
git -C "$git_dir" config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

# Gets all branches from origin
git -C "$git_dir" fetch origin

# Make worktrees placeholder dir for future git worktrees
# Make resources placeholder dir for future project resources
# (can be anything: documents, images, other repos, etc...)
worktree_dir=$repo_dir/worktrees
# resources_dir=$repo_dir/resources
exploring_dir=$repo_dir/exploring

mkdir "$worktree_dir" "$exploring_dir"
