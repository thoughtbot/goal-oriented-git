# Remotes and tracking branches

## The commands

    git remote
    git clone
    git fetch
    git push
    git checkout -t

## Remote repositories

A <dfn>remote repository</dfn> (or <dfn>remote</dfn> for short) is another
version of a git repository -- usually on another computer, but sometimes just
in another folder -- which you can <dfn>push</dfn> commits to and
<dfn>fetch</dfn> commits from.

Remote repositories are central to the idea that git is a *distributed* version
control system. With older, centralised version control systems everyone working
on a project would send their commits to a single, central repository. With git,
everyone working on a project commits to their own local repository but is able
to push their commits to any number of remote repositories, and fetch their
collaborator's commits from any number of remote repositories. Often
collaborators on a project will set up a single, central repository to contain
the canonical version of a project, but this is a convention; git does not
enforce it, and users can step outside of the convention when it is convenient
to do so.

## URLs

You can refer to a remote repository using a URL, in much the same way you would
refer to a web page. Git can talk to remote repositories using various
protocols, but you are most likely to see the SSH, git, and HTTP protocols.

For example, I have a remote repository containing this book on a Linux server.
The server is at `pingu.georgebrock.com`, and there's a user on the server
called `git` who can access the server over SSH. The path to the repository
(from the git user's home directory) is `./git-book.git`. Putting these pieces
together, I can use the following SSH URL to refer to my remote repository:

    ssh://git@pingu.georgebrock.com/git-book.git

I can also use this shorthand, which will probably be familiar to you if you've
used `scp` (a program which securely copies files between servers over the SSH
protocol):

    git@pingu.georgebrock.com:git-book.git

## Naming remotes

URLs are long, complicated and easy to mistype. It's much easier to give each
remote a name. The `git remote` command lets us manage a list of remotes for
each git repository.

To add a named remote, use `git remote add`:

    git remote add <var>name</var> <var>url</var>

For example, I think of my server at `pingu.georgebrock.com` as "pingu", so
when I added the remote repository for this book I used the following command:

    git remote add pingu git@pingu.georgebrock.com:git-book.git

To see a list of remotes for the current repository, we can use this command:

    git remote -v

The `-v` is short for `--verbose`. It gives me the URLs that the names refer to,
without it `git remote` would just list the names.

## Tracking branches

As we've seen in earlier chapters, commits in git exist on branches. When
working with remotes, git maintains special branches called <dfn>remote-tracking
branches</dfn> which show the state of the remote repository.

For example, if I have a branch called <code>master</code> on my remote called
<code>pingu</code>, there will be a remote-tracking branch in my local
repository called <code>pingu/master</code>. This represents the state of the
the <code>master</code> branch on the <code>pingu</code> remote the last time I
fetched commits from that remote.

## Fetching commits from a remote

You can update remote-tracking branches with the `git fetch` command.

For example, this could be the state of the repository on pingu. There are 8
commits (A, B, C ... H) on the `master` branch:

    A -- B -- C -- D -- E -- F -- G -- H
                                       ^
                                     master

In my local version of the repository, I have three commits on the master branch
(A, B, C) and three more on the remote-tracking branch (D, E, F). My
remote-tracking branch doesn't know about commits G and H yet, because I've not
run `git fetch` for a while:

    A -- B -- C -- D -- E -- F
              ^              ^
            master       pingu/master

When I run `git fetch` my remote-tracking branch is updated with the new commits
(G and H) from the version of the repository on pingu:

    A -- B -- C -- D -- E -- F -- G
              ^                   ^
            master            pingu/master

Note that my local `master` branch hasn't changed. The `git fetch` command only
updated remote-tracking branches, it never effects local branches.

### Pulling

It's very common to merge changes from a remote-tracking branch into the
corresponding local branch immediately after fetching them.  Continuing the
example above, I could use the command `git merge pingu/master` to do this.
This works in exactly the same way as merging two local branches; it would merge
the changes from `pingu/master` into `master`, and leave us in this position:

    A -- B -- C -- D -- E -- F -- G
                                  ^
                              master
                              pingu/master

Because this is so common, git provides a single command to `fetch` and then
`merge`: `git pull`.

## Pushing commits to a remote

Whenever I've committed some changes to this book, I use the `git push` command
to *push* them to my remote repository. This serves two purposes: It provides me
with a backup, and it makes my commits available to other people who have access
to the same remote repository.

## Associating local branches with remote branches

Fetching, pulling and pushing all need to know which remotes and branches to
operate on. Each local branch has the concept of an <dfn>upstream</dfn> branch;
a remote branch it is associated with and should pull from or push to. The
upstream branch is set in different ways depending on when and how the branch is
created.

### Branches created locally

When a branch is created locally, it's upstream branch can be set the first time
it is pushed. For example:

    git push --upstream pingu my-feature-branch

This command will push the branch `my-feature-branch` to the remote `pingu`, and
set the upstream branch for `my-feature-branch` to the corresponding branch on
`pingu`.

### Branches created in a remote

When a branch is created in a remote, a local version can be created and checked
out:

    git checkout --track pingu/their-feature-branch

This will create a local branch called `their-feature-branch` whose upstream
branch is set to the corresponding branch on `pingu`.
