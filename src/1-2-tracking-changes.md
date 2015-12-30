# Goal: Track changes

If you can see how the incremental changes to your files led to their current
state, then you have a better chance of understanding the project you are
working on, fixing problems that arise, and collaborating successfully with
others. In order to unlock the riches promised by a comprehensive history, we
have to first build that history, one change at a time.

By now, you should have installed Git on your system, and so you are ready to
create your first Git repository.

A <dfn>repository</dfn> is the place where Git keeps track of all of the changes
for a given project. We need to create a repository for each project we want to
track with Git.

## The `git init` command

The `git init` command creates a new Git repository to keep track of changes to
the files in the directory where the command is run. For example:

`# reset_example
`# mkdir -p projects/git-book
`# echo "First chapter" > projects/git-book/chapter1.txt
`$ cd projects/git-book
`$ git init

This creates a new Git repository in the `projects/git-book` directory, telling
Git that from now on we want to track the changes made to one or more of the
files in that directory. Since we haven't told Git exactly which files to track
yet, the repository is empty; this is true even if the `projects/git-book`
directory isn't empty.

Running the command creates a new directory, `projects/git-book/.git`, where Git
will store the files that represent the repository. This is the <dfn>Git
directory</dfn>, whereas `projects/git-book` is the <dfn>working
directory</dfn>.

To begin with, we'll modify files in the working directory, just as we would if
we weren't using Git, and then tell Git to track the changes we've made in the
repository. As we get more advanced, we'll be able to conjure old or alternative
versions of our project from the repository, summoning them to the working
directory to do our bidding.

## The `git add` and `git commit` commands

The individual changes that make up the history of our project are called
<dfn>commits</dfn>. We commit changes to the Git repository in the same way we might
commit something to memory; once it's committed we won't lose it.

Each commit consists of a set of changes---like adding a new file, changing the
contents of a file, deleting a file, or changing the properties of the file in
some way---and a <dfn>commit message</dfn> that describes the changes, and the
name and email address of the commit's author.

Git provides a staging area called the <dfn>index</dfn>, where we build up a set
of changes before committing them to the repository. We'll come back to why the
index is useful later, but for now it's enough to know that creating a commit is
a three stage process:

1. Change files in the working directory.
2. Add some or all of those changes to the index.
3. Create a commit from the changes staged in the index.

Let's say we've created a file in our `git-book` working directory called
`chapter1.txt`, and we're happy with the contents of the file and want to commit
it to the repository. That's step one, step two is to add the file to the index
using the `git add` command:

`# cd projects/git-book
`$ git add chapter1.txt

And then we can create a commit using the `git commit` command:

`# cd projects/git-book
`$ git commit --message "Add first draft of chapter one"

The commit message, passed using the `--message` argument, describes the changes
in the commit: in this case, it adds the first draft of chapter one.

By committing, we've drawn a line in the sand. Whatever changes we make to
chapter one in future, we'll always be able to get back to this
<dfn>revision</dfn> of the file. Even though a commit only contains the changes
made to a file since it was last committed, we can think of a commit as
representing a particular revision of our project, since Git is able to use all
of the commits up to that point to reconstruct the revision of the project that
existed when that commit was made.

Now that we've included it in a commit, the file `chapter1.txt` will be
<dfn>tracked</dfn> by Git: if we make any changes to the file in future, Git
will notice that it has changed and needs to be committed again.

## Summary

* Create a new Git repository with `git init`
* Stage related changes in the index with `git add`
* Commit the changes in the index with `git commit`
