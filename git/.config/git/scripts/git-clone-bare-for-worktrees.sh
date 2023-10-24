#!/usr/bin/env bash

# Usage:
#   $ git-clone-bare-for-worktrees git@github.com:name/repo.git my-repo
#
#   => Clones to a my-repo/.git directory
#   => Creates my-repo.git/worktrees directory
#   => Creates my-repo.git/research directory

# TODO: optionally accepts upstream repo as argument
# TODO: if there's a main (or master) branch repo on origin add it as a worktree

# Inspired from:
#   see: https://morgan.cugerone.com/blog/how-to-use-git-worktree-and-in-a-clean-way/
#   see: https://morgan.cugerone.com/blog/workarounds-to-git-worktree-using-bare-repository-and-cannot-fetch-remote-branches/
#   see: https://levelup.gitconnected.com/git-worktrees-the-best-git-feature-youve-never-heard-of-9cd21df67baf

# Plan is to create worktrees as siblings of $git_dir directory.
# Example of targeted structure:
#
# <my-project>
# ├── .git/      (bare repository)
# ├── worktrees/ (all project git worktrees)
# │   ├── main/
# │   ├── new-awesome-feature/
# │   ├── hot-fix-62/
# │   └── ...
# └── research/ (all project resources that I DON'T want to be tracked by git)
#     ├── some-doc.pdf
#     ├── some-image.jpg
#     ├── can-be-repos-too.git
#     ├── random.txt
#     └── ...

set -e

# if its variable $1 .. $n you need write to
# a regular variable to use the substitution
url=$1

# Define git directory
if [ "$2" != "" ]; then
    # $2 was given
    repo_dir=$2
else
    # $2 was not given
    # if url ends on .git cleans it so it won't get duplicated when defining $repo_dir
    basename=${url##*/}

    # strips .git from the end of the url if there's one
    repo_dir=${basename%.*}

    # Define a regular expression pattern to match "<any-word-1>:<any-word-2>"
    # so when cloning a repository using:
    # example: $ git cb my:repository
    #            only the <repository> part will be considered
    # SEE: the main git config at ~/.config/git/config for better understanding
    pattern="^[[:alnum:]]+:[[:alnum:]]+"

    if [[ $repo_dir =~ $pattern ]]; then
        # The word matches the pattern "<any-word-1>:<any-word-2>"

        # strips the <any-word-1> part of "<any-word-1>:<any-word-2>"
        repo_dir="${repo_dir/*:/}"
    fi
fi

git_dir=$repo_dir/.git

git clone --bare "$url" "$git_dir"

# Explicitly sets the remote origin fetch so we can fetch remote branches
# see: https://github.com/ThePrimeagen/git-worktree.nvim#troubleshooting
git -C "$git_dir" config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

# Gets all branches from origin
git -C "$git_dir" fetch origin

# Make worktrees placeholder dir for future git worktrees
worktree_dir=$repo_dir/worktrees

# Make resources placeholder dir for future project resources
# (can be anything: documents, images, other repos, etc...)
research_dir=$repo_dir/research

mkdir "$worktree_dir" "$research_dir"
