# Goal: Understand what is being tracked

So far, we've made simple commits with just one file, but in a complex project
there could be dozens or even hundreds of files. How do we know if they've been
changed since they were last committed, or if they're even tracked by Git?

In the last chapter we defined three important locations:

1. The working directory, where we keep and work on the current version of our
   project's files.
2. The index, where we build up a set of changes ready to commit.
3. The repository, where Git stores the history of our project as a series of
   commits.

Git provides a number of commands for comparing the state of the repository, the
index, and the working directory, so we can stay up to date with what's changed.

## The `git status` command

The `git status` command will tell us the status of our files. It lists all of
the changed or untracked files in the working directory, split into the
following groups:

1. **Changes to be committed**: files which have already been added to
   the index with `git add` and will be included the next time we run `git
   commit`.
2. **Changes not staged for commit**: files which have been changed in
   the working directory, but not added to the index.
3. **Untracked files**: files which have never been committed and
   therefore aren't tracked by Git.

For example:

`# cd examples/1-3-understanding-what-is-being-tracked
`# git reset --hard HEAD
`# echo 'CHAPTER 2' > chapter2.txt
`# git add chapter2.txt
`# echo 'CHAPTER 3' > chapter3.txt
`# sed -i '' 's/CHAPTER ONE/CHAPTER 1/' chapter1.txt
`$ git status

In this case, `chapter2.txt` has just been added to the index for the first time
with `git add`, `chapter1.txt` is tracked by Git but has been modified since it
was last committed, and `chapter3.txt` isn't tracked by Git yet.

`git status` won't mention any files that haven't been changed since they were
last committed. If none of your files have changed, `git status` will let you
know that you have clean working directory:

`# cd examples/1-3-understanding-what-is-being-tracked
`# git reset --hard HEAD
`# git clean --force
`$ git status

 `git status` isn't concerned with the details of exactly what's
changed in each file, just which files have been changed and therefore could be
committed.

## The `git diff` command

Now we know which files in our working directory have changed, it would be good
to see the details of those changes. The `git diff` command provides this.

If you've used the Unix `diff` utility then the output of `git diff` might look
familiar, but while `diff` shows the difference between
files, `git diff` shows the difference between versions of the same file.

Without any arguments, `git diff` shows all changes that haven't been committed
or added to the index.

For example, here's what `chapter1.txt` the list time it was committed:

`# cd examples/1-3-understanding-what-is-being-tracked
`# git reset --hard HEAD
`# echo 'CHAPTER 2' > chapter2.txt
`# git add chapter2.txt
`# echo 'CHAPTER 3' > chapter3.txt
`# sed -i '' 's/CHAPTER ONE/CHAPTER 1/' chapter1.txt
`! git show HEAD:chapter1.txt

Since that commit, we've modified `chapter1.txt` in the working directory to
look like this:

`# cd examples/1-3-understanding-what-is-being-tracked
`! cat chapter1.txt

Running `git diff` shows us exactly what the differences are:

`# cd examples/1-3-understanding-what-is-being-tracked
`$ git diff

The first section gives some information about the change Git is showing: which
versions are being compared, and on which lines of which files there are
changes. Other than the file's name, this is more useful to machines than
humans, and I usually don't read it carefully. More important are the changes
themselves:

`# cd examples/1-3-understanding-what-is-being-tracked
`! git diff | sed -e '1,/@@/d'
`# git clean -f
`# git reset --hard HEAD

Lines beginning with a `-` indicate a line that has been removed, and lines
beginning with a `+` indicate a line that has been added. In this case a line
has been changed: the old version of the line was removed, and the new version
was added.

Lines beginning with a space---lines that lack both `+` and `-`---are
unchanged, but are shown to give the context of the change.

### The `git diff --staged` command

Remember that without any arguments `git diff` shows us the changes that haven't
been staged in the index yet. `git diff --staged` shows us the changes that
*have* been staged, but haven't yet been committed. In other words, `git diff
--staged` shows you the changes that would be included in the commit, if you
were to run `git commit` right now.

It can be useful to run `git diff --staged` before `git commit` as a final check
that the right changes have been staged in the index.

## Summary

* Look at the state of the working directory with `git status`
* Look at the changes since the latest commit with `git diff`
* Look at the contents of the index with `git diff --staged`
