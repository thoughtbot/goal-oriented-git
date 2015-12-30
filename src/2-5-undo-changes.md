# Goal: Undo changes

In the previous chapter, we saw how to use Git's search tools to find a change
we were having second thoughts about. Having found the commit, how can we
reverse that change? We could use `git show` to view the changes it introduced
and manually unpick them by typing them out again or using copy-and-paste. That
would be a lot of manual, error-prone work, and fortunately Git provides tools
to undo changes we'd rather hadn't been committed.

## The `git revert` command

The simplest way of undoing the changes in a commit is to use the `git revert`
command. This command creates a new commit which contains the opposite set of
changes to the commit we want to undo: if a line was added in the original
commit, it will be removed in the new commit, and vice versa.

Here is the commit we identified in the previous chapter:

`# reset_example 2-4-searching-the-repository
`$ git show 3ba3f98

When we pass the commit's identifier as an argument to the `git revert` command,
Git will construct the opposite set of changes, and commit them.

`$ git revert 3ba3f98

Notice that the output of the `git revert` command contains the identifier of
the new commit.

`# export HEAD=$(git rev-parse HEAD | colrm 8)
`$ git show $HEAD

Like the `git commit` command, `git revert` will open a text editor so that we
can write a description of the commit, but unlike `git commit` it helpfully
provides a default commit message with some information about the commit that is
being reverted. It's usually a good idea to leave the default message
intact---so that you'll be able to recognise a revert commit when you're reading
the history---and to add a note to the end to explain *why* it was useful to
revert this commit.

## The `git reset` command

While `git revert` is useful for undoing a commit from somewhere back in the
distant history of the project, we have other options if we want to undo our
most recent commit or commits.

The `git reset` command will reset the repository back to an earlier state. It's
a flexible command that can be used in various ways; we'll see it again later in
the book, but for now let's focus on two uses:

1. To remove changes from the index: they will still exist in the working
   directory, but they won't be included in the next commit.
2. To remove the last commit or commits from the repository: the commit's
   changes will still exist in the working directory, but it will be as if they
   were never committed.

### Remove changes from the index

Without any arguments, `git reset` will clear the index without changing the
working directory or repository: it undoes the `git add` command. This kind of
reset is useful when you're staging some changes, but you realise that you're
not really ready to commit them yet, or that you've staged the wrong changes.

Continuing with my novel, I've made some changes to `chapter1.txt` that I think
are ready to commit, so I add them to the index, and `git status` shows that
they are staged to commit:

`# echo "They were friends." >> chapter1.txt
`$ git add chapter1.txt
`$ git status

I was about to commit, but I've changed my mind: these changes aren't all
related, and it would probably be better to split them up over multiple commits.
I can remove them from the index using `git reset`:

`$ git reset

`git status` confirms that `chapter1.txt` has still been changed, but is no
longer staged to commit:

`$ git status

### Remove commits from the repository

When it's given a commit as an argument, `git reset` will clear the index, and
roll the repository back to that revision, as if the subsequent commits had
never happened. It won't change the working directory, so the current state of
our files won't be lost, but the history of how we got to that state will be.

This kind of reset is useful when you realise that your last commit was too big,
and you'd like to break it down as several smaller commits. Or maybe you realise
that the changes in your last two commits would make more sense spread across
three commits.

Although undoing commits is useful, it should make us a little uncomfortable.
Commits are the record of how our project has changed, and if we undo them
there's a very real chance that we'll lose some valuable history along the way.
Over the last few chapters we've seen a few of the ways that having access to a
project's history can help us; hopefully we've seen enough that the idea of
throwing part of the history away gives us pause.

Let's see how this works with a real example: I want to undo the last two
commits to my novel. First, to refresh our memory, let's look at what those
commits contain:

`# reset_example 2-4-searching-the-repository
`$ git log --oneline

Remember that `git log` shows the most recent commit first, so I'm trying to
undo `e8393d4` and `2ba40c1`. The first of these commits adds some information
about what Bob does at the cafe:

`$ git show e8393d4

The second commit removes all references to the cafe:

`$ git show 2ba40c1

In order to undo these commits, I need to reset the repository to the last
revision before they were made: `1dba13c`.

`$ git reset 1dba13c

This doesn't change the working directory, but I have lost some information in
the process. Let's look at the state of the repository after I reset:

`$ git log --oneline

The log looks good: the two commits we wanted to undo are gone. How about the
working directory?

`$ git status

The status looks OK, too: there are some uncommitted changes in the working
directory, but the commits we just removed made changes to both `chapter1.txt`
and `chapter2.txt`, and yet our working directory only has changes to
`chapter1.txt`:

`$ git diff

The changes to `chapter2.txt` in our two deleted commits cancelled each other
out: the first commit added a sentence about what Bob did at the cafe, and the
second took it away again. By using `git reset` to remove these two commits,
we've lost a potentially useful bit of history; there's no longer any record
that this sentence ever existed, which means we no longer have the option of
recovering it if we change our minds.  Equally importantly, the information
associated with the two commits is gone too: we no longer know who made those
commits, when, or why.

`git reset` is a useful tool, but it should be used with caution, and is least
risky when used to undo a single commit immediately after it was made. Git is a
powerful tool, and will often give us more than enough rope to hang ourselves.
