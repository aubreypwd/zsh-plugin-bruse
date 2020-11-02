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

### w/out Parameters

e.g. 


```bash
bruse
```

#### `.bruse.json`

```json
{
  "node": "10",
  "php": "7.2"
}
```

Using the above example, if a `.bruse.json` file exists, it will read through it automatically run e.g. `bruse node@10` and `bruse php@7.2` when you run `bruse` w/out any parameters.

#### `.nvmrc`

If you have an `.nvmrc` file with a semver value, e.g. `12` or `10.4` it will automatically, too, try and install it using `bruse node@<version>` when you run `bruse` w/out any parameters.


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
