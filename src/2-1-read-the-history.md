# Goal: Read the history

Now that we've recorded some history, we get to use it.

You'll often want to view your whole commit history. It can be a great way of
refreshing your memory about what you were working on, or seeing what others
have done on a collaborative project.

## The `git log` command

The `git log` command will show all of the commits, with their authors, dates,
and messages:

`# cd examples/2-1-read-the-history
`$ git log

In this example, the project has two commits. The most recent commit is shown
first.

Each commit starts with an long string of numbers and letters that uniquely
identifies the commit:

`# cd examples/2-1-read-the-history
`! git log -n 1 | head -n 1

These identifiers are very important. Many of the ways of using our Git history
involve referring to specific commits, and we often do that using these unique
identifiers.

As a concrete example, `git log` has shown us the commit messages, but what if
we want to see the changes contained in one of these commits?

## The `git show` command

The `git show` command will show you the contents of a specific commit, which
means we need to tell it which commit to show; this is the first of many
examples of a place where we can use a commit's unique identifier.

`# cd examples/2-1-read-the-history
`$ git show c7d5d6876da96f8aff9b08416119ff0178d776cf

The output should all be familiar: it starts with information about the commit,
which is very similar to the output produced by `git log`, and then shows the
changes made by the commit, which is very similar to the output produced by `git
diff`.

## Summary

* Use `git log` to see a list of commits.
* Use `git show <identifier>` to see the contents of a specific commit.
