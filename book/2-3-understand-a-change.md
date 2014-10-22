# Goal: Understand a change

It can often be the case in a long running project that we come across something
in one of our files that doesn't quite make sense. Using the project's Git
history to see where something came from can help to make it more clear. Git can
help us answer questions like "why was this changed?" and "what was here before
it changed?"

Here's a confusing file called `chapter1.txt`. Let's dig into the history and
see if we can work out what's going on:

`# cd examples/2-3-understand-a-change
`! git show aaad9ad:chapter1.txt

It looks like there should be a list here, but there's only one item, and
confusingly it seems like it should be the last item. Maybe this just needs to
be rephrased, but maybe something was deleted that shouldn't have been.

## The `git blame` command

The first command we can use to understand this file is `git blame`, which will
tell us which person, and more importantly which commit, is to blame for the
current state of each line in the file:

`# cd examples/2-3-understand-a-change
`# git checkout aaad9ad
`$ git blame chapter1.txt

Each line of the file is printed with some annotations: the abbreviated
identifier of the commit in which it was last changed, the author and date of
that commit, and the line number.

In this case, both of those lines were last changed in the commit `61966bf`. The
next step in our investigation should probably be to look at that commit and see
the full change:

`# cd examples/2-3-understand-a-change
`$ git show 61966bf

This is a clue on the road to solving this mystery: we now know that the
ambiguous section started as a list, but a couple of items were subsequently
removed. It's a good start, but we still don't know why the list was
subsequently altered. Maybe the correct fix is to rephrase the content, but
maybe those list items should never have been removed in the first place.

To find out where the list items went, we can turn to another command we've used
before: `git log`.

## Filtering `git log`

We've used `git log` to look at all of the commits in our project. In this case,
we want something more specific. The `git log` command accepts a range of
commits and a file path as arguments, which we can use to only see commits that:

1. happened *after* the list was first introduced in commit `61966bf`, and
2. contain changes to the file `chapter1.txt`.

The most common way to refer to a range of commits is `first..last`, where
`first` and `last` are both commit identifiers, or one of the other ways we've
seen of referring to a commit. Git also allows us to omit the end of the range,
assuming when we do so that we mean the most recent commit. In our case, we want
to see everything after commit `61966bf`, which introduced the list, so we can
use the range `61966bf..`.

Putting this together with the file path `chapter1.txt`, we get this command:

`# cd examples/2-3-understand-a-change
`$ git log 61966bf.. chapter1.txt

Our carefully filtered log tells us that only one commit touched the file we're
interested in during the time we're interested in. Let's take a closer look:

`# cd examples/2-3-understand-a-change
`$ git show aaad9ad

Finally we have the full context of this confusing file. It started out as a
list, but a couple of items were removed because they were contradictory, which
left the surrounding content in a confusing state. Now that we have the full
story, we can confidently fix the problem.

## Summary

* Use `git blame <file>` to find out which commit last changed the lines in a file.
* Use `git log <range> <file>` to see relevant commits.
