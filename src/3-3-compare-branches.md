# Goal: Compare branches

Tracking our commits on different branches helps to organise our work, and
isolate unrelated efforts from each other, but it also makes the history harder
to read and understand. We no longer have a single line of commits, but multiple
branches spreading out from the original `master` branch, and then---as we'll
see in the next chapter---coming back together.

Git provides tools to visualise the history, even in projects with a complex
branching structure.

## Visualising the tree with `git log`

We've previously seen that the `git log` command can be used to read the
history, and that arguments like `--oneline` can be used to customise the
output. Now that we're reading more complex histories, it's time to learn a few
more arguments for the `git log` command.

We'll continue using the book example from the previous chapter: there were a
few commits on the `master` branch, and the we created a `chapter-2` branch, and
the history diverged into a commit tracking work on a new chapter on the
`chapter-2` branch, and a new editing commits back on the `master` branch.

Using the `git log` arguments we've already learnt, we looked at the history of
each branch individually:

`# cd examples/3-3-compare-branches
`$ git checkout master
`$ git log --oneline
`$ git checkout chapter-2
`$ git log --oneline

### The `--all` argument

First of all, it would be great if we could get `git log` to show us *all* of
the commits at once, without having to switch branches and compare the output of
multiple logs. The conveniently named `--all` argument will make `git log` do
this for us:

`# cd examples/3-3-compare-branches
`$ git log --oneline --all

### The `--graph` argument

We can see all of the commits, but there's no structure: we can't tell which
commit is part of which branch. Passing the `--graph` argument to `git log`
fixes this; it causes Git to draw a visual representation of the branching
structure in the left hand margin:

`# cd examples/3-3-compare-branches
`$ git log --oneline --all --graph

We can see that after the commit `Fix typo in chapter 1`, the history branches
off in two directions.

### The `--decorate` argument

This is looking pretty good, but we're still missing some important information.
Which branch is which? If we pass the `--decorate` argument to `git log`, then
Git will decorate the commit at the tip of each branch with the name of the
branch:

`# cd examples/3-3-compare-branches
`$ git log --oneline --all --graph --decorate

Notice that one commit is also decorated with the label `HEAD`. In the chapter
on "referring to commits" we said that `HEAD` is the current revision of the
project, usually the most recent commit. Now that we're switching between
branches we can define `HEAD` a little more thoroughly: `HEAD` is the current
revision of the project, usually the most recent commit on the current branch.

Since we have the `chapter-2` branch checked out, `HEAD` is the most recent
commit on that branch. If we switch to the `master` branch, the `HEAD` changes:

`# cd examples/3-3-compare-branches
`$ git checkout master
`$ git log --oneline --all --graph --decorate

## The `git show-branch` command

Using the log is useful for getting an overview, but Git also provides tools to
compare two or more specific branches.

The `git show-branch` command takes a list of branch names as arguments, and
will show all of the commits on each of those branches, but only as far back as
the point where they diverged:

`# cd examples/3-3-compare-branches
`# git checkout chapter-2
`$ git show-branch master chapter-2

The output of this command can be a little hard to interpret, so let's break it
down into pieces.

The first section of the output lists the branches, and the most recent commit
on each. The staggered symbols on the left are column headings: in the list of
commits below we can tell which branches they belong to by looking at which of
the first two columns contain a symbol.

`# cd examples/3-3-compare-branches
`! git show-branch master chapter-2 | head -n 3

This is followed by a list of commits. This commit is only on the `chapter-2`
branch, indicated by the `*` symbol in the second column:

`# cd examples/3-3-compare-branches
`! git show-branch master chapter-2 | tail -n 3 | grep -E '^ \*'

This commit is only on `master`, indicated by a `+` symbol in the first column:

`# cd examples/3-3-compare-branches
`! git show-branch master chapter-2 | tail -n 3 | grep -E '^\+ '

And finally this commit---the common ancestor of both branches, the point where
they diverged---is present on both branches, indicated by `+*` in the first two
columns:

`# cd examples/3-3-compare-branches
`! git show-branch master chapter-2 | tail -n 1

## Summary

* Pass the `--all` argument to `git log` to see commits from all branches.
* Pass the `--graph` argument to `git log` to see a visualisation of the
  branching structure.
* Pass the `--decorate` argument to `git log` to label the commits with branch
  names.
* The combination `git log --all --oneline --graph --decorate` is very useful.
* Use the `git show-branch <first-branch> <second-branch>` command to compare
  branches.
