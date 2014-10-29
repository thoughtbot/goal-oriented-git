# Goal: Beautiful commits

A good commit should contain a set of related changes, with a description of why
those changes were made. Much of the power of tracking history is lost if we
bundle lots of unrelated changes together, or don't take the time to describe
them properly.

So far we've been committing all of the changes in a file. Real world work is
rarely that neat and tidy, though. Perhaps we were half way through changing a
document, and found ourselves fixing an un-related typing error; perhaps we
forgot to commit a set of changes before moving on to the next idea; perhaps we
just got distracted: whatever the cause, a real working directory can be a messy
place.

This is where the index really comes into its own: By updating the index before
we commit, we can carefully select the changes that go into each commit; even
going so far as to split unrelated changes to the same file over several
commits.

## The `git add --patch` command

In addition to the name of the file, the `git add` command can take some
options that control exactly what is added to the index. Particularly useful is
the `--patch` option, which shows you each change in turn and lets you decide if
it should be added to the index or not.

Let's look at an example: I've made some unrelated changes within the same file,
so I want to add them as two commits. `git diff` tells me I have the following
changes:

`# cd examples/1-4-beautiful-commits
`# git reset 3acba2e
`$ git diff

On the first line, I've corrected a typing error by changing `fxo` to `fox`, and
then I've added some additional material about the dog's reaction to the fox.
These changes aren't related, so we should create two different commits. `git
add --patch` will allow us to add the correction to the index, without the new
content:

`# cd examples/1-4-beautiful-commits
`! git-add-patch-demo q

Git will show the differences -- using the familiar style of `git diff` -- one
piece at a time, and ask me what I want to do with each piece. In this case,
since my changes are very close together, Git's assuming that they're probably
related and showing me a single piece. The output ends with a question: `Stage
this hunk [y,n,q,a,d,/,s,e,?]?`. There are a lot of options, but thankfully
entering `?` will explain the other options:

`# cd examples/1-4-beautiful-commits
`! git-add-patch-demo ? q | sed -n '/Stage/,/@@/p' | sed '/@@/,$d'

Most of the time we can answer with `y` to add the change to the index, or `n`
to skip it and move on to the next change. In this case, though, I need to use
`s` to tell Git that even though these changes are close to each other they
should be split up and added to the index separately:

`# cd examples/1-4-beautiful-commits
`! git-add-patch-demo s q | sed -n '/Stage/,/Stage/p'

This change is just the correction on the first line, so I can stage it in the
index using `y`. Once it's staged, Git will show me the next change.
Since this change isn't related to the one I've already added to the index, I
don't want to include it in the same commit, so I can skip it with `n`:

`# cd examples/1-4-beautiful-commits
`! git-add-patch-demo s y n | sed -n '/ y$/,/ n$/p'

This was the last change, so `git add --patch` exits, and I can commit the fix
and then the additional content:

`# cd examples/1-4-beautiful-commits
`$ git commit --message "Fix typing error"
`$ git add chapter1.txt
`$ git commit --message "Add information about the dog's reaction"
`# git reset --hard original

I almost always use the `--patch` option when I'm adding files to the index,
even when I think all of the changes will end up as a single commit: It gives me
the opportunity to review my changes, and has saved me many times from
committing something that wasn't quite right.

## Summary

* Good commits are focused on a set of related changes
* Use `git commit --patch` to add specific changes to the index
