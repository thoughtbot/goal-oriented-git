# Goal: Understand what is being tracked

So far, we've made simple commits with a few files, but in a complex project
there could be dozens or even hundreds of files. How do we know if they've been
changed since they were last committed, or if they've ever been committed at
all?

Git provides a number of commands for comparing the state of the repository,
index, and working directory, so we can stay up to date with what's changed.

## The `git status` command

The `git status` command will tell us the status of the files in our working
directory. This command isn't concerned with the details of exactly what's
changed in each file, just which files have been changed and therefore could be
committed.

`git status` won't mention any files that haven't been changed since they were
last committed. If none of your files have changed, `git status` will let you
know that you have `nothing to commit, working directory clean`.

When there are changes that could be committed, the output is broken down into
three sections:

1. **Changes to be committed**, that is files which have already been added to
   the index with `git add` and will be included the next time we run `git
   commit`.
2. **Changes not staged for commit**, that is files which have been changed in
   the working directory, but not added to the index.
3. **Untracked files**, that is files which have never been committed and
   therefore aren't tracked by Git.

For example:

    $ git status
    # On branch master
    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to unstage)
    #
    #       new file:   chapter2.txt
    #
    # Changes not staged for commit:
    #   (use "git add <file>..." to update what will be committed)
    #   (use "git checkout -- <file>..." to discard changes in working directory)
    #
    #       modified:   chapter1.txt
    #
    # Untracked files:
    #   (use "git add <file>..." to include in what will be committed)
    #
    #       chapter3.txt

In this case, `chapter2.txt` has just been added to the index for the first time
with `git add`, `chapter1.txt` is tracked by Git but has been modified since it
was last committed, and `chapter3.txt` isn't tracked by Git yet.

## The `git diff` command

Now we know which files in our working directory have changed, it would be good
to see the details of those changes. The `git diff` command provides this.

If you've used the Unix `diff` utility then the output of `git diff` might look
familiar. The difference is that while `diff` shows the difference between
files, `git diff` shows the difference between versions of the same file.

Without any arguments, `git diff` shows all changes that haven't been committed
or added to the index.

For example, here's the most recently committed version of a file called
`chapter1.txt`:

    CHAPTER ONE

    This is the first chapter, where it all begins.

In the working directory, we've modified `chapter1.txt` to look like this:

    CHAPTER 1

    This is the first chapter, where it all begins.

Running `git diff` shows us the change:

    $ git diff
    diff --git a/chapter1.txt b/chapter1.txt
    index 1e41245..80a7940 100644
    --- a/chapter1.txt
    +++ b/chapter1.txt
    @@ -1,3 +1,3 @@
    -CHAPTER ONE
    +CHAPTER 1

     This is the first chapter, where it all begins.

The first section establishes some context: which versions are being compared,
which files, and which lines the changes appear on. More important than the
context are the changes themselves:

    -CHAPTER ONE
    +CHAPTER 1

     This is the first chapter, where it all begins.

Lines beginning with a `-` indicate a line that has been removed, and lines
beginning with a `+` indicate a line that has been added. In this case a line
has been changed: the old version of the line was removed, and the new version
was added.

### The `git diff --staged` command

If `git diff` without any arguments shows us the changes that haven't been
staged in the index yet, then `git diff --staged` shows us the changes that have
been staged but haven't yet been committed. In other words, `git diff --staged`
shows you the changes that would be included in the commit, if you were to run
`git commit` right now.

It can be useful to run `git diff --staged` before `git commit` as a final check
that the right changes have been staged in the index.

## Summary

* Look at the state of the working directory with `git status`
* Look at the changes since the latest commit with `git diff`
* Look at the contents of the index with `git diff --staged`
