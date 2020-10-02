# `bruse`

A function that helps you use (`brew link`) different versions of packges using [homebrew](https://brew.sh).

## Usage

```bash
bruse <package> <version>
```

e.g.:

```bash
bruse php 7.4
bruse node 12
```

![Screenshot](screenshot.gif)

- _Note, if you request a version that is not installed, this script will try install it for you._
- Also, packages are currently limited to `brew`, so `brew cask` packages are not supported.

## Requires

- `brew`
- `xargs`
- `grep`

## Install

Using [antigen](https://github.com/zsh-users/antigen):

```bash
antigen bundle aubreypwd/zsh-plugin-bruse@1.0.0
```

## Development

Install the package on `master`:

```bash
antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-bruse.git
```

...and contribute upstream by working in `$HOME/.antigen/bundles/aubreypwd/zsh-plugin-bruse`.

---

## Changelog

### 1.0.0

- First version
- Extensively tested with `php` package
