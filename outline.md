# Goal-Oriented Git

## 1. Getting started

1. Introduction
    * About this book
    * What is a git repository?
    * Installing git
    * `git config`
    * `git help`
2. Goal: Tracking changes
    * `git init`
    * `git add` (including `-p`)
    * `git commit`
3. Goal: Understand what is tracked
    * `git diff`
    * `git status`

## 2. Using history

1. Introduction
    * Referring to commits (`gitrevisions(7)`)
2. Goal: Read the history
    * `git log` (including `--oneline`)
3. Goal: Understand a change
    * `git blame`
    * `git show`
    * `git checkout`
4. Goal: Searching the repository
    * `git log` (including `-S`)
    * `git grep`
    * `git bisect`
5. Goal: Undo changes
    * `git revert`
    * `git reset` (soft and `--hard`)

## 3. Branching

1. Introduction
    * What are branches?
    * `git branch`
2. Goal: Create a branch
    * `git checkout -b`
3. Goal: Compare branches
    * `git diff` (revisited)
    * `git show-branch`
    * `git log` (including `--all` and `--graph`)
4. Goal: Combine branches
    * `git merge`
    * `git mergetool`
    * `git reset --hard` to undo a merge
5. Goal: Move branches
    * `git rebase` (including `--onto`, `--continue`, and `--abort`)
    * `git reset --hard` to undo a rebase
6. Goal: Delete a branch
    * `git branch -d` and `-D`

## 4. Collaboration

1. Introduction
    * What are remotes?
    * What are remote tracking branches?
2. Goal: Add a remote
    * `git remote`
    * `git clone`
3. Goal: Publish changes
    * `git push` (including `-u`)
4. Goal: Retrieve changes
    * `git fetch`
    * `git pull`
    * `git checkout -t`


Not covered, but probably useful if they fit somewhere:

* `git stash`
* `git tag`
