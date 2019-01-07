# File Organizer

This is a CLI utility to help with file organization. It was something needed, but also written to learn a bit of Ruby,
so some code may be a bit rough.

## Usage

`ruby organizer.rb DIR` where `DIR` is the directory to organize. The script will then give a variety of choices of what
to do with the files, such as the following:

```
Processing files in .

> ./organizer.rb
[0] ./test
[N]ext [R]ename [F]older Create [D]elete [Q]uit
```

Choosing the number before a directory will move the file to that directory while the named options correspond to the
appropriate actions.