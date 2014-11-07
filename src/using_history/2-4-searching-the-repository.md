# Goal: Searching the repository

Git provides some powerful search tools which let us search through the files
Git is tracking and the commits we've made in the past.

## Filtering `git log` by content

In the last chapter, we saw how to filter the output of `git log` to only show
us commits in a certain range, or commits that contain changes to certain files,
so we could see what changes had been made. This time we want to start from the
other side: we know the change we're interested in, but we don't know when or
where it happened.

Let's pretend I'm writing a novel, which has the following Git history:

`# cd examples/2-4-searching-the-repository
`$ git log --oneline

I deleted a section of the novel, but I'm having second thoughts: I think the
story will flow better if I put it back. Unfortunately, I deleted it some time
ago, and I don't remember all of the details, just that it centred around a
character called Alice.

There are a few commit messages that mention removing content, but by filtering
the commit log to only show commits which contain changes that add or remove the
word "Alice", I can narrow down my search.  We do this using the `-S` option:

`# cd examples/2-4-searching-the-repository
`$ git log --oneline -S Alice

Now I've narrowed down the search to three commits, and only one of the
messages mentions removing content, so it looks like I've found my deleted
scene.

`# cd examples/2-4-searching-the-repository
`$ git show 3ba3f98

The `-S` option can be combined with the other filtering techniques we've seen,
so if I had remembered the file that contained the change, or the range of
commits it was part of, I could have narrowed down the search even further.

You can think of filtering the `git log` as searching in time: Given its
knowledge of the history of your project, you're asking Git to tell you about
times when certain kinds of changes were made. It's also useful to be able to
search in space: given a fixed point in time -- in Git's terminology, a specific
revision of the project -- where does a certain word or phrase appear in the
project's tracked files?

## The `git grep` command

The `git grep` command searches through all of the tracked files for a
particular word or phrase. If you're familiar with the Unix `grep` utility,
you'll find that `git grep` works in much the same way.

Let's say we want to find all references to Alice in all of the tracked files in
the working directory. We can use `git grep`:

`# cd examples/2-4-searching-the-repository
`$ git grep Alice

This tells me that Alice is currently only mentioned once, in the file
`chapter1.txt`. I know that the commit `3ba3f98` removed some mentions of
Alice--we just used the `git log -S` command to find it--and I want to find out
how often she was mentioned before that commit.

If you've read the chapter on how to "Refer to commits", you'll know that if we
have the ID of a commit, we can use a `~1` suffix to reference the commit before
that commit. In this case, we're interested in the revision before `3ba3f98`, so
we can use `3ba3f98~1`.

The `git grep` command can take a commit as a second argument, which tells it to
search that particular revision of our project:

`# cd examples/2-4-searching-the-repository
`$ git grep Alice 3ba3f98~1

I've found my answer: Alice used to be mentioned in `chapter1.txt` and
`chapter2.txt`.

`git grep` can match more than just simple words and phrases: it supports a
powerful pattern matching language called Regular Expressions, which means you
can search for things like "any two digit number", or "either the word 'Alice'
or the word 'Bob'". How to write regular expressions is beyond the scope of this
book, but there is plenty of information on the Web, and even whole books on the
topic.

## Summary

* Find commits that mention a word or phrase with `git log -S <word>`.
* Find tracked files that mention a word or phrase with `git grep <word>`.
* Search previous revisions with `git grep <word> <revision>`.
