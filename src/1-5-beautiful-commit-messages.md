# Goal: Write beautiful commit messages

In the last chapter we talked about the importance of carefully choosing the
changes that go into each commit: we wanted each change to be easy to understand
in isolation so our history would be easier to work with.

Carefully selecting the contents of the commit is only half the story: writing
descriptive commit messages is also important for building an
understandable---and therefore useful---history.

## What to cover

When we look back at commits, Git can show us *what* has changed by showing us
the contents of the commit, but it cannot show us *why* unless we use our commit
messages to explain the reasoning behind each change.

You should write commit messages that address the following questions:

* What need do the changes in this commit address?
* If it's not clear from looking at the changes in the commit, how do the
  changes address that need?
* What other consequences might this change have?

That list of questions might seem like a lot, but don't be afraid to write a
long commit message if you need to. The next time you're trying to remember why
you changed your project in a certain way you'll be very glad you took the time
to write it down.

Thinking through your change as you commit it to Git can also be a useful
opportunity to review your work, and catch mistakes or consequences you didn't
think of earlier.

## How to lay it out

The first line of a commit message should be a short summary of the commit's
intention, no more than 50 characters long; think of it like the subject line of
an email. When we start looking back at the commits we've made---we'll see how
in the next section, "Using history"---Git will often only show the first line
of the commit message, so making it short and meaningful will keep those lists
of commits tidy and useful.

After the one-line summary and a blank line, we can write a longer description
of the commit, often running to several paragraphs or lists of bullet points;
think of this like the body of an email. It may be relevant to include Web links
to additional information here. In a software project a problem has often been
discussed on a bug tracking Web site before it is fixed, and including a link to
this discussion when committing the changes that fix the problem can be very
valuable.

It's customary to keep each line of the description to 72 characters or fewer:
as with the one line summary, this length limit will keep the body of the commit
message legible in all the various contexts where it might appear.

As a concrete example, when I commit this chapter to Git, the message could look
something like this:

```
First draft of "Write beautiful commit messages"

Vague commit messages aren't very useful. This chapter attempts to
impress upon readers the importance of detailed and specific commit
messages.

* Add chapter 1.5 (beautiful commit messages).
* Update chapter 2.1 (read the history) to refer back to chapter 1.5.
```

## Write commit messages in your text editor

So far, we've used the `--message` argument to specify a simple, one-line commit
message when we make a commit.

If you omit this argument, Git will open your text editor and prompt you to
write a commit message there. Writing the commit message in an editor is almost
always preferable to using `--message`: it gives you the time and space to think
through the changes you've made, and describe them in more than a single short
line.

Many text editors also have settings that help enforce the line-length
conventions discussed above, so you can focus on what you're writing, and let
your editor worry about whether or not it's time to insert a new line.

When you've finished writing the commit message, just save the file and close
your editor. Behind the scenes, Git has given your editor a temporary file where
you can write your message, and when you save and close that file, Git will
extract your message from it.

## Set your text editor

If you're on a Linux or Unix system, and you frequently use the command line,
chances are you've already set an `$EDITOR` or `$VISUAL` environment variable.
Git will pick up on that setting and use it.

If you're on a different operating system, unfamiliar with setting environment
variables, or you want to use a different editor for Git commit messages, you
can explicitly tell Git which editor to use. This is done by setting
`core.editor` with the `git config` command:

```
$ git config --global core.editor vim
```

The `--global` argument tells Git that this setting should apply to all of your
repositories, without it Git would change this setting only for the current
repository.

`core.editor` is the name of the setting, and in this case I'm telling Git that
the command to open my editor is `vim`. You should replace `vim` with whatever
command you use to launch your favourite text editor from the command line. For
example if you use the Sublime Text editor you might use:

```
$ git config --global core.editor "subl -n -w"
```

## The `git commit --verbose` command

In order to write such a detailed commit message, it can be useful to refer to
the changes you are committing while you write the commit message. If we pass
the `--verbose` argument to `git commit`, then it will include a list of the
changes we are committing---again, in that familiar `git diff` style---at the
bottom of the file Git opens in our editor.

When using the `--verbose` option, Git won't include the list of changes, or
anything you add after it, in the commit message. Make sure you write your
commit message at the top of the file.

Git will helpfully mark the place where the message ends and the summary of the
changes starts with an ASCII art pair of scissors cutting along a dotted line:

```
# ------------------------ >8 ------------------------
# Do not touch the line above.
# Everything below will be removed.
```

## Summary

* Write commit messages that describe why changes were made.
* The first line of the commit message should be a short summary, 50 characters
  or fewer.
* Use `git config --global core.editor <editor>` to set your text editor.
* Use `git commit --verbose` to see the changes you are committing in your
  editor.
