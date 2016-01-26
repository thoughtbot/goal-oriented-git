# Goal: Avoid repeating long commands

In the last chapter, we learnt some new arguments to the `git log` command that
combine to produce a useful visualisation of the branching structure of our Git
repositories.

The command we ended up with was quite long:

```
$ git log --oneline --all --graph --decorate
```

This command is going to come in very useful in the rest of our discussion on
branches, but typing it out over and over would be boring and error prone.

To avoid all of this needless repetition, let's take a break from our discussion
of branches and learn how to create <dfn>aliases</dfn>: our own short and
memorable names for long and complex commands.

## The `git config` command

Back at the beginning of the book, we told Git our names with a command like
this:

```
$ git config --global user.name "George Brocklehurst"
```

Later, when we were talking about writing helpful commit messages, we saw the
same command again:

```
$ git config --global core.editor vim
```

Since we're about to meet it for the third time, it's time we were all formally
introduced.

The `git config` command is used to customise Git by changing our settings.
Let's break down the examples used above:

* `git config` is the command.
* `--global` tells Git that this setting applies to all of your Git
  repositories. If you omit this argument, then the setting change will only
  apply to the current repository. All of your global Git settings are stored in
  a file called `.gitconfig` in your home directory---if you want to use Git on
  multiple computers, you might want to keep this file in sync between them.
* `user.name` and `core.editor` are both examples of settings we've changed.
  Git settings are arranged into sections that indicate what they're
  customising. For example, the setting `name` is in the `user` section.
* The last argument, `George Brocklehurst` or `vim` in the examples above, is
  the value I assigned to the setting.

Throughout this book, I'll continue to highlight settings that you might find
useful, but there are too many to cover all of them. If you want to see a more
comprehensive list, you can look in Git's documentation:

```
$ git help config
```

## Creating aliases

Aliases are just another kind of customisation. Any setting in the `alias`
section of our Git configuration defines an alternative name for another
command.

Let's create an alias for the command we've been using to look at the structure
of our Git branches. Instead of typing all of this:

```
$ git log --oneline --all --graph --decorate
```

It would be great it we could just type this:

```
$ git graph
```

We can create this alias by setting the `alias.graph` setting to `log --oneline
--all --graph --decorate`:

```
$ git config --global alias.graph "log --oneline --all --graph --decorate"
```

While most of the examples in this book are designed to work with Git's default
settings, we'll be making heavy use of this new `git graph` alias in the next
few chapters, so please add it to your own Git configuration if you want to
follow along with the examples.

## Summary

* Use `git config --global <section>.<name> <value>` to update your Git
  configuration.
* Define aliases with `git config --global alias.<name> <command>`.
* Use aliases just like built-in Git commands.
* The next few chapters will assume a `graph` alias for `log --oneline --all
  --graph --decorate`, i.e. that you have run `git config --global alias.graph
  "log --oneline --all --graph --decorate"`.
