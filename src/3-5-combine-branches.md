# Goal: Combine branches

We've learnt how we can use branches to explore parallel worlds, keeping our
work on different parts of our projects isolated while it's still in progress.

This isolation is useful for a time: it allows us to keep our ideas separate, to
work on one part of a project while another person works on another, or to try
an experiment without worrying about how to undo the changes if it fails.

There comes a point, however, when the branch is finished (whatever that may
mean for your particular project), and it no longer needs to be isolated; it
should be <dfn>merged</dfn> will the other finished branches and become part of
the larger whole.

## The role of the `master` branch

Git is very flexible, it allows us to use branches however we choose, but there
are some conventions that a lot of projects follow.

As we've seen, a newly created Git repository has a single, default branch
called `master`. The conventional role of the `master` branch is to contain all
of our finished work.

If you follow this conventions---and in most cases, you probably
should---working on a new part of your project will often go like this:

1. Create a new branch for the new part of your project. This is often called a
   <dfn>feature branch</dfn>.
2. Carry out your work on the feature branch, committing regularly.
3. When the work is complete, merge the changes from the feature branch back
   into the `master` branch.

Let's look at a situation we've seen before, with a `master` branch and a
`chapter-2` feature branch. Notice we're using the `git graph` alias we defined
in the previous chapter:

`# cd examples/3-3-compare-branches
`$ git graph

Our draft of chapter 2 is complete, so how do we incorporate it back into the
`master` branch?

## The `git merge` command

The `git merge` command combines two branches together. That is, it incorporates
all of the changes that were made on one branch into another branch.

In this case, we want to incorporate the changes from `chapter-2` into `master`.
The first step in merging is to make sure we've checked out the `master` branch,
since that's the branch we want to add to:

`# cd examples/3-3-compare-branches
`$ git checkout master

Next, we use the `git merge` command with the name of the branch we're merging:

`# cd examples/3-3-compare-branches
`$ git merge chapter-2

Compare the resulting graph to the original graph above:

`# cd examples/3-3-compare-branches
`$ git graph
`# git reset --hard origin/master
`# git checkout chapter-2

A new commit has been created on the `master` branch, called a <dfn>merge
commit</dfn>, which has two parent commits. The `chapter-2` branch is still
there, but hasn't moved forward.

The latest revision in our master branch now includes all of the work we had
previously done on `master`, and all of the work we had done on `chapter-2`.

## Summary

* The `master` branch is usually reserved for finished work.
* Other branches are referred to as <dfn>feature branches</dfn>.
* To merge one branch into another, use the `git merge <branch>` command.
