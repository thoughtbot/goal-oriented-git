## What is a Git repository?

A repository is just that-- a place to safely store things.  Git builds on this
concept by not only safely storing a set of documents, but also the history of
documents as we make changes to them.

To begin using Git, we will need to create a repository.

The [git-init] command is the first used for any repository.

[git-init]: http://git-scm.com/docs/git-init "git-init Man Page"

The `git init` command-- when run in a non-git directory and with no arguments--
creates a new, empty repository in the current directory.

Practically speaking, this means that Git creates a `.git/` directory in the
current directory containing configuration and all of the files it will use to
manage the repository.

Note the disparity-- even if the current directory is not empty, the Git
repository is.

This is because of Git's three states.

The working directory may contain many files that Git is unaware of.  It exists
on the file system.

The staging area contains files and changesets that Git has been informed of but
which have not been committed.

Finally, the Git directory, or repository, contains information on the files and
history of changes to those files that Git is tracking.

Once a set of documents have been committed to a repository, Git has a snapshot
of those documents which it can use later to restore them to their captured
state.

If Git is the tool we use to store documents, then the repository is that safe
place.
