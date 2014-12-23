# Goal: Read the history

Now that we've made some commits, we can begin to use them to explore the
history of our project.

You'll often want to view your whole commit history. It can be a great way of
refreshing your memory about what you were working on, or seeing what others
have done on a collaborative project.

## The `git log` command

The `git log` command will show all of the commits, with their authors, dates,
and messages:

`# reset_example 2-1-read-the-history
`$ git log

In this example, the project has two commits. The most recent commit is shown
first.

Each commit starts with an long string of numbers and letters that uniquely
identifies the commit:

`! git log -n 1 | head -n 1

These identifiers are very important. Many of the ways we can use our projects'
Git history involve referring to specific commits, and we often do that using
these unique identifiers.

### The `--oneline` option

In the last chapter we discussed detailed commit messages, which can often get
very long. If every commit message runs to dozens of lines, the full output of
`git log` can be a little overwhelming, and difficult to quickly scan for a
particular commit.

The `git log` command accepts many options to customise the format of the
output; one of the most useful is `--oneline`, which only outputs the first line
of the commit message, and the first few characters of the unique identifier:

`$ git log --oneline

Remember that the first line of the commit message should be a short summary of
the commit, so this is a great way to get an overview of recent changes.

Running `git help log` will give you comprehensive documentation on the other
ways you can customise the output of `git log`.

## The `git show` command

While `git log` gives us an overview of many commits, the `git show` command
will show the contents of a specific commit. We need to tell it which commit to
show; this is the first of many examples of a place where we can use a commit's
unique identifier.

`$ git show c7d5d6876da96f8aff9b08416119ff0178d776cf

The output should all be familiar: it starts with information about the commit,
which is very similar to the output produced by `git log`, and then shows the
changes made by the commit, which is very similar to the output produced by `git
diff`.

## Summary

* Use `git log` to see a list of commits.
* Use `git log --oneline` to see just the first line of the commit messages.
* Use `git show <identifier>` to see the contents of a specific commit.
