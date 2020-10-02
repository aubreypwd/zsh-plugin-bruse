# `bruse`

A function that helps you use (link) different versions of packges using [homebrew](https://brew.sh].

## Usage

```bash
bruse <package> <version>
```

e.g.:

```bash
bruse php 7.4
```

- _Note, if you request a version that is not installed, this script will try install it for you._
- Also, packages are currently limited to `brew`, so `brew cask` packages are not supported.

## Requires

- `brew`
- `xargs`
- `grep`

<sup>*</sup> If using [homebrew](https://brew.sh) on macOS, these will automatically be installed.

## Install

Using [antigen](https://github.com/zsh-users/antigen):

```bash
antigen bundle aubreypwd/zsh-plugin-bruse@1.0.0
```

## Development

Install the package on `master`:

```bash
antigen bundle aubreypwd/zsh-plugin-bruse
```

...and contribute upstream by working in `$HOME/.antigen/bundles/aubreypwd/zsh-plugin-bruse`.

---

## Changelog

### 1.0.0

- First version
- Extensively tested with `php` package
