# Goal: Refer to commits

In the last chapter we learnt how to use the `git log` command to find a
commit's identifier, which we could use with the `git show` command to view the
contents of that commit.

Commit identifiers can be quite cumbersome to use: they're long, complex, and
not very memorable. Fortunately, Git provides a range of alternatives.

Let's imagine the following Git history, and see how we can refer to the commits
without using the long-winded commit identifiers:

`# cd examples/2-2-refer-to-commits
`$ git log

## Abbreviating commit identifiers

Let's say we want to look at the latest commit. What we've seen so far is `git
show` with the full identifier:

`# cd examples/2-2-refer-to-commits
`$ git show e420911b9d16d0fd75a12a71202673ae32fc933a

In the previous chapter we saw that the `git log --oneline` command only prints
the start of the commit identifier. It does this because it's possible to use
the beginning of the identifier to identify a commit, as long as you use enough
of it to be unique among all of the commit identifiers in the repository. In
practice, this usually means that we can use the first 6 or 7 characters of the
identifier without any problems, evan in a long running project with thousands
of commits.

`# cd examples/2-2-refer-to-commits
`$ git show e420911

If you don't give enough characters to uniquely identify a single commit, Git
will let you know that you've provided an ambiguous argument:

`# cd examples/2-2-refer-to-commits
`$ git show e42

## Relative commit references

Each commit in our Git repository has a <dfn>parent commit</dfn>: the
commit that immediately preceded it. If we know the identifier of a commit, we
can tell Git to give us its parent commit using a `~` suffix. For example:

`# cd examples/2-2-refer-to-commits
`$ git show e420911~1
`$ git show e420911~2

## Using the commit message

These techniques are all great if you know the commit's identifier, or at least
the identifier of one of its descendants, but identifiers aren't as memorable as
commit messages. Fortunately it's possible to refer to commits using a part of
their message, too:

`# cd examples/2-2-refer-to-commits
`$ git show :/Second

If there are multiple commits that match the given word, then Git will pick the
newest matching commit.

## There are more!

We've only scratched the surface of the many ways of referring to Git commits.
If you want all the options, then Git's comprehensive help system is the place
to go:

    $ git help revisions

If you're reading this book in order to learn Git for the first time, then many
of the concepts in that document won't be familiar to you yet, but don't be
afraid to explore the documentation.

## Summary

* Use abbreviated commit identifiers.
* Use relative commit references, e.g. `e420911~2`.
* Refer to commits using their message, e.g. `:/Second`.
* Check `git help revisions` for more.
