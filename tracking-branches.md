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
refer to a website. Git can talk to remote repositories using various protocols,
but you are most likely to see the SSH, git, and HTTP protocols.

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

For example, when I added the remote on `pingu.georgebrock.com` to the
repository for this book I used the following command. I think of the server as
"pingu", so that's what I called my remote:

    git remote add pingu git@pingu.georgebrock.com:git-book.git

To see a list of remotes for the current repository, we can use this command:

    git remote -v

The `-v` is short for `--verbose`. It gives me the URLs that the names refer to,
without it `git remote` would just list the names.

## Pushing

Whenever I've committed some changes to this book, I *push* them to my remote
repository. This serves two purposes: It provides me with a backup, so if I lose
my laptop I haven't lost all of my hard work, and it makes my commits available
to other people who have access to the same remote repository.


## Fetching

## Pulling

