# Remotes and tracking branches

## Remote repositories

A <dfn>remote repository</dfn> (or <dfn>remote</dfn> for short) is another
version of a git repository. It is usually on another computer, but sometimes
it's in another directory on the same computer. Commits can be
<dfn>fetched</dfn> from and <dfn>pushed</dfn> to a remote repository.

Remote repositories are central to the idea that git is a *distributed* version
control system. With older, centralised version control systems everyone working
on a project would send their commits to a single, central repository. With git,
everyone working on a project commits to their own local repository but is able
to push their commits to any number of remote repositories, and fetch their
collaborators' commits from any number of remote repositories. Often
collaborators on a project will set up a single, central repository to contain
the canonical version of a project, but this is only a convention: git does not
enforce it, and users can step outside of the convention when it is convenient
to do so.

### URLs

Remote repositories are referred to with URLs, in much the same way as web
pages. Git can talk to remote repositories using various protocols, but the SSH,
git, and HTTP protocols are the most common.

There is a remote repository containing this book on a Linux server. The server
is at `pingu.georgebrock.com`, and there is a user on the server called `git`
who can access the server over SSH. The path to the repository (from the git
user's home directory) is `./git-book.git`. Putting these pieces together, the
following SSH URL can be used to refer to the remote repository:

    ssh://git@pingu.georgebrock.com/git-book.git

Alternatively, since the remote uses SSH, an alternative syntax is available
that reflects the style used by other SSH tools:

    git@pingu.georgebrock.com:git-book.git

### Naming remotes

URLs are long, complicated, and easy to mistype. It's much easier to give each
remote a name. The `git remote` command lets us manage a list of remotes for
each git repository.

To add a named remote, use `git remote add`:

    git remote add <name> <url>

For example, I think of my server at `pingu.georgebrock.com` as "pingu", so
when I added the remote repository for this book I used the following command:

    git remote add pingu git@pingu.georgebrock.com:git-book.git

## Tracking branches and upstreams

Git commits exist on branches. When working with remotes, git maintains special
branches called <dfn>remote-tracking branches</dfn> which show the state of the
branches in the remote repository.

For example, if there is a branch called `master` on a remote called `pingu`,
there will be a remote-tracking branch in the local repository called
`pingu/master`.

Each local branch can also have an <dfn>upstream</dfn>: a remote-tracking branch
that git will associate with the local branch when pushing and pulling changes.
Much like naming remotes, setting upstreams isn't essential, but it cuts down on
a lot of tedious and repetitive typing.

## Getting changes from a remote

Remote-tracking branches are updated with the `git fetch` command.

For example, this could be the state of the repository on pingu. There are 8
commits (A, B, C ... H) on the `master` branch:

    A -- B -- C -- D -- E -- F -- G -- H
                                       ^
                                     master

In the local version of the repository, there are three commits on the master
branch (A, B, C) and three more on the remote-tracking branch (D, E, F)
representing the state of the repository on pingu the last time `git fetch`
was run. The remote-tracking branch doesn't include commits G and H, because
`git fetch pingu` hasn't been run since they were added to the remote:

    A -- B -- C -- D -- E -- F
              ^              ^
            master       pingu/master

The next time `git fetch pingu` is run, the remote-tracking branch is updated
with the new commits (G and H) from the repository on the pingu remote:

    A -- B -- C -- D -- E -- F -- G
              ^                   ^
            master            pingu/master

Note that the local `master` branch hasn't changed. The `git fetch` command only
updates remote-tracking branches, it never effects local branches. The remote
commits are copied to the local repository though, so they can be merged into a
local branch, cherry-picked, or read without accessing the remote repository.

### Pulling

It's very common to merge changes from a remote-tracking branch into the
corresponding local branch immediately after fetching them. Continuing the
example above, the command `git merge pingu/master` would do this. This works
in exactly the same way as merging two local branches; it would merge the
changes from `pingu/master` into the current branch (`master`), leaving the
repository looking like this:

    A -- B -- C -- D -- E -- F -- G
                                  ^
                              master
                              pingu/master

Because this is so common, git provides a single command to fetch and then
merge: `git pull`.

If the current branch has an upstream, then typing `git pull` is sufficient. Git
will fetch from the upstream repository, and then merge changes from the
upstream branch.

### Creating a local branch from a remote branch

The `git pull` command is only useful when there is already a local branch to
merge the changes into. What about a branch that exists on the remote, but
doesn't have a corresponding local branch yet?

The `git checkout --track` command can be used to create a new local branch
based on the remote branch, and to set the local branch's upstream correctly so
that `git pull` will do the right thing in future.

For example, if there was a remote-tracking branch called `pingu/new-branch`
then the command `git checkout --track pingu/new-branch` would create a new,
local branch pointing to the same commit, with its upstream set as
`pingu/new-branch`.

## Sending changes to a remote

The `git push` command will push commits from a local branch to the
corresponding branch in a remote repository. If the current branch has an
upstream, then typing `git push` is sufficient. Git will push only the current
branch to the correct remote.

### Creating a remote branch from a local branch

When there is a new local branch that has never been pushed before, it can be
pushed to the remote with this command:

    git push --upstream <remote> <branch>

The `--upstream` part sets the upstream for the local branch, so that `git push`
and `git pull` can be used with this branch without any extra arguments.

## Summary

* Create named remotes with `git remote add <name> <url>`
* Get updates from the remote with `git fetch` and `git pull`
* Create a local branch from a remote branch, and set the upstream with
  `git checkout --track <remote>/<branch>`
* Create a remote branch from a local branch, and set the upstream with
  `git push --upstream <remote> <branch>`
