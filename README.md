Alias Manager
=================

Simple command line utility for maintaining an alias file (`~/.alias`) that can
be sourced for directory aliases for jumping around file system easily.

### Build

`crystal build alsmgr.cr --release`

Then move the executable (e.g. `alsmgr` on OSX) to your "bin" directory or some directory on your PATH.

### List directory aliases

`alsmgr`

### Add a directory alias (applies to current directory)

`alsmgr <alias-name>`

e.g. `alsmgr bob` when present working directory is `/Users/bob/work`
will result in `alias bob='/Users/bob/work'` being added to `.alias`
file in $HOME directory that can be sourced with ZSH for directory
aliases.

### Delete an alias

`alsmgr <alias-name> -d`

### Backup

With any `add` or `delete` the current `.alias` before changes will be copied to `.alias.bak`
in your HOME directory.