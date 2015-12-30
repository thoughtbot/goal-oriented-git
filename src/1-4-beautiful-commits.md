# Goal: Make beautiful commits

A good commit should contain a set of related changes, with a description of why
those changes were made. Much of the power of tracking history is lost if we
bundle lots of unrelated changes together in the same commit, or don't take the
time to describe them properly.

So far we've been assuming that all of the changes to a file belong in the same
commit. Real world work is rarely this neat and tidy, though. Perhaps we were
half way through changing a document, and found ourselves fixing an un-related
typing error; perhaps we forgot to commit a set of changes before moving on to
the next idea; perhaps we just got distracted: whatever the cause, a real
project's working directory can be a messy place.

This is where the index really comes into its own: By updating the index before
we commit, we can carefully select the changes that go into each commit; even
going so far as to split unrelated changes to the same file over several
commits.

## The `git add --patch` command

In addition to the name of a file, the `git add` command can take some
options to control exactly what is added to the index. Particularly useful is
the `--patch` option, which shows you each change in turn and lets you decide if
it should be added to the index or not.

Let's look at an example: I've made two changes to the same file but they are
unrelated, so I want to add them to the repository as two separate commits. `git
diff` tells me I have the following changes:

`# reset_example 1-4-beautiful-commits
`# git reset 3acba2e
`$ git diff

On the first line, I've corrected a typing error by changing `fxo` to `fox`, and
then on the third line I've added some additional material about the dog's
reaction to the fox. `git add --patch` will allow us to go through each change
in turn, and decide if we want to add it to the index.

`! git-add-patch-demo q

Git will show the changes---using the familiar style of `git diff`---one at a
time, and asks me what I want to do with each <dfn>hunk</dfn> with the question
`Stage this hunk [y,n,q,a,d,/,s,e,?]?`. Most of the time we can answer with `y`
to add the change to the index, or `n` to ignore it for now and move on to the
next change. In this case, it's a little more complicated: since my changes are
very close together, Git's assumed that they're probably related and shows them
as a single hunk. I want to split up this hunk, and since I need something
beyond a basic "yes" or "no" I can use `?` to explain the other options:

`! git-add-patch-demo ? q | sed -n '/Stage/,/@@/p' | sed '/@@/,$d'

After looking through my options, I see I can use `s` to tell Git that even
though these changes are close to each other they should be split up so that I
can treat them differently:

`! git-add-patch-demo s q | sed -n '/Stage/,/Stage/p'

Git splits the change into two hunks, and shows me the first of them.
This change is just the correction on the first line, so I can stage it in the
index using `y`. Once it's staged, Git will show me the next change.
Since this change isn't related to the one I've already added to the index, I
don't want to include it in the same commit, so I can skip it with `n`:

`! git-add-patch-demo s y n | sed -n '/ y$/,/ n$/p'

I've now made a decision about each of the changes to the tracked files in my
working directory, so `git add --patch` exits, and I can commit the correction
that's staged, and then stage and commit the additional content:

`$ git commit --message "Fix typing error"
`$ git diff
`$ git add chapter1.txt
`$ git commit --message "Add information about the dog's reaction"

I almost always use the `--patch` option when I'm adding files to the index,
even when I'm confident that all of the changes are related and will end up as a
single commit: It gives me the opportunity to review my changes, and has saved
me many times from committing something that wasn't quite right.

## Summary

* Good commits are focused on a set of related changes
* Use `git commit --patch` to add specific changes to the index
