# Goal: Create a branch

Even though we've not discussed branches so far, we've already been using them
without realising it. All new Git repositories are created with a single branch
called `master`, and when we make commits they become part of that branch.

## The `git branch` command

The `git branch` command, when we don't give it any arguments, will show a list
of our repository's branches. If you try it in a new repository you'll see
the default `master` branch:

`# cd examples/3-2-create-a-branch
`$ git branch

Let's say we want to work on a new chapter in a book; finishing the chapter is
going to take a while, and we will make many commits in the process. We can
create a new branch for this chapter, which will keep the commits together while
we're working on it, and still leave us free to switch back to the `master`
branch to work on other parts of the book.

We can also invoke the `git branch` command with the name of a new branch that
we want to create, and it will be created:

`# cd examples/3-2-create-a-branch
`$ git branch chapter-2
`$ git branch

Notice that when we ran `git branch` again, there is a `*` by the `master`
branch. This indicates that the `master` branch is the current branch; if we
make any new commits they will be part of the master branch, not the `chapter-2`
branch.

## The `git checkout` command

The `git checkout` command lets us switch between branches.

`# cd examples/3-2-create-a-branch
`$ git checkout chapter-2

We can see which branch we're on using the `git branch` command and looking for
the `*`:

`# cd examples/3-2-create-a-branch
`$ git branch

You may have noticed that the first line of the output from `git status`
tells us the current branch:

`# cd examples/3-2-create-a-branch
`$ git status

## Committing to branches

We've created two branches, but so far they are identical. If we use the `git
log` command on each of our two branches we'll see the same set of commits:

`# cd examples/3-2-create-a-branch
`$ git checkout master
`$ git log --oneline
`$ git checkout chapter-2
`$ git log --oneline

Let's add a commit to each branch. First, we'll commit some feedback from the
book's editor on the `master` branch:

`# cd examples/3-2-create-a-branch
`$ git checkout master
`# echo "It has been edited." >> chapter1.txt
`$ git diff
`$ git add chapter1.txt
`$ git commit --message "Incorporate editor's feedback into chapter 1"

Notice that the output from `git commit` includes the name of the current
branch, in this case, `master`.

We've added the phrase "It has been edited." to `chapter1.txt` and committed the
change, but if we change to another branch it'll be as if that change never
happened:

`# cd examples/3-2-create-a-branch
`$ git checkout chapter-2
`$ cat chapter1.txt

The change we made on `master` isn't there. If we look at the output of `git
log`, the commit isn't there, either:

`# cd examples/3-2-create-a-branch
`$ git log --oneline

Changes committed on the `master` branch aren't visible on our `chapter-2`
branch, leaving us free to work on two different things in parallel, without
worrying that they might get tangled up with each other.

Next, let's commit the first draft of chapter two on the `chapter-2` branch:

`# cd examples/3-2-create-a-branch
`# echo "# Chapter 2" > chapter2.txt
`# echo "This is the first draft of the second chapter." >> chapter2.txt
`$ git add chapter2.txt
`$ git commit --message "First draft of chapter 2"

This new commit does show up when we run `git log`:

`# cd examples/3-2-create-a-branch
`$ git log --oneline

When we switch back to the `master` branch, we don't see the chapter 2 commit,
but we do see our edits to chapter 1:

`# cd examples/3-2-create-a-branch
`$ git checkout master
`$ git log --oneline
`# git reset --hard HEAD~1
`# git branch -D chapter-2
`# git clean -f

Notice that the branches share the same history, up to the point where we
created the `chapter-2` branch.

## The `git checkout -b` command

When we create a branch, it's often because we immediately want to start
creating commits on that branch. To streamline this process a little, Git
provides a command to create a new branch and immediately check it out.

So far, we've created new branches with `git branch`, and then checked them out
with `git checkout`:

`# cd examples/3-2-create-a-branch
`$ git branch chapter-3
`$ git checkout chapter-3
`# git checkout master 2>/dev/null
`# git branch -D chapter-3

Instead, we can pass the `-b` argument to `git checkout`. This will first create
the branch we've requested, and then immediately check it out:

`# cd examples/3-2-create-a-branch
`$ git checkout -b chapter-3
`# git checkout master 2>/dev/null
`# git branch -D chapter-3

## Summary

* List branches with the `git branch` command.
* Create a new branch with the `git branch <name>` command.
* Switch between branches with the `git checkout <name>` command.
* Quickly create a branch and switch to it with the `git checkout -b <name>`
  command.
