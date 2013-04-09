# Remotes and tracking branches

## The commands

    git remote
    git clone
    git fetch
    git push
    git checkout -t

## Remote repositories

A <dfn>remote repository</dfn> is another git repository elsewhere -- usually on
another computer -- which you can <dfn>push</dfn> commits to and
<dfn>fetch</dfn> commits from.

Remotes can be referred to by path or URL, but if you frequently use the
same remote you can also use the `git remote add` command to give your remote a
name. For example, I have a copy of this book on a Linux server. I push all of
my changes to the server, so I don't want to type the URL over and over again.
I used the following command to create a named remote:

    git remote add pingu git@pingu.georgebrock.com:git-book.git

* `git remote add` is the command to add a named remote.
* `pingu` is the name I've chosen for the remote, because that's what I call my
  server.
* `git@pingu.georgebrock.com:git-book.git` is the address of the server, and the
  path to the repository. It breaks down like this:
    * `git` is a user on my server.
    * `pingu.georgebrock.com` is the server's host name.
    * `git-book.git` is the path to the git repository from the `git` user's
      home directory.

## Tracking branches

As we saw in chapter [n], changes in Git exist within branches.
