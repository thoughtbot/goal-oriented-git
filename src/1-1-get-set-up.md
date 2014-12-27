# Goal: Get set up

## What is Git?

Git is a <dfn>version control system</dfn>. When you work on a project---whether
it's a piece of software, a Web site, a book, or anything else that goes through
many revisions---using version control lets you track the changes that you make,
return to previous versions, try alternative ideas, and seamlessly merge your
own work with the work of others.

Git can track any kind of files, but it's best suited to <dfn>plain text
files</dfn>. If you're not familiar with the term, these are files that just
contain unformatted text as opposed to images or things like
<abbr title="Portable Document Format">PDF</abbr>.

## Using the command line

Everything covered in this book will be done from the command line. While there
are various applications that provide graphical interfaces for Git, the command
line interface is powerful, flexible, and works on every platform. Issuing
commands, one-by-one, forces us to take things step-by-step so we can really
understand what's happening.

If you're not familiar with using command line tools, then there are a few terms
you'll need to know. Here's a typical Git command:

    git commit --message "My first commit"

We'll cover what it does later, but for now let's name its component parts:

* `git` is the <dfn>command</dfn>: it's the name of the program we want to run.
* `commit` is the <dfn>sub-command</dfn>: it tells Git what we want it to do.
  Not all command line interfaces use sub-commands, but since Git uses them for
  almost everything, in the context of this book we can just think of
  `git commit` as the command.
* `--message` and `"My first commit"` are both <dfn>arguments</dfn>: they are
  passed to the command to further nuance its behaviour. Arguments often come in
  pairs, where we tell Git what option we want to use---in this case
  `--message`---and then a value for that option---`"My first commit"`.

## Installing and configuring Git

Before we begin, you'll need to install Git and get it set up:

1.  Go to the Git downloads page, and follow the instructions for your operating
    system: [http://git-scm.com/downloads](http://git-scm.com/downloads)
2.  Make sure you can run Git commands from the command line. If you're on Mac
    OS X you can use the Terminal.app application; if you're on Windows there's
    an application called <i>Git Bash</i> that comes with Git.

    The following command should tell you what version of Git you have installed:

    `$ git --version

    As with all of the examples in this book, the `$` at the beginning of
    the line indicates that this is a command; you shouldn't include it in the
    command you type.

    If you see a version number, as show above, then Git is installed
    successfully. If you see a message along the lines of `command not found`,
    then Git isn't correctly installed yet.
3.  When Git is tracking changes to our files, it needs to know who made those
    changes---we'll see why this is important when we explore Git's
    collaborative features in Part 4.

    To identify yourself, and therefore the changes you track with Git, you
    need to set Git's `user.name` and `user.email` settings with the following
    commands, replacing my name and email address with your own:

    `$ git config --global user.name "George Brocklehurst"
    `$ git config --global user.email george@georgebrock.com

    The `--global` argument tells Git that these settings should apply to
    all of the Git projects you work on, so you'll only need to set this once.
    Don't worry if you don't completely follow this now; we'll talk about the
    `git config` command in more detail later in the book.
