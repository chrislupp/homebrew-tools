# Homebrew Tools

The official [Homebrew](https://brew.sh) tap for tools developed by
[Christopher Lupp](https://github.com/chrislupp).

## Usage

Install a formula directly:

```sh
brew install chrislupp/tools/<formula>
```

Homebrew will add the tap automatically. Alternatively, add the tap first and
then install formulae by their short names:

```sh
brew tap chrislupp/tools
brew install <formula>
```

To use the tap in a `Brewfile`:

```ruby
tap "chrislupp/tools"
brew "<formula>"
```

## Available formulae

- [`papercut`](https://github.com/chrislupp/Papercut) — Convert source code
  files to PDF with configurable formatting.

## Maintainer notes

Formula definitions live in [`Formula/`](Formula). Before publishing a formula
change, run:

```sh
brew audit --strict --online chrislupp/tools/<formula>
brew install --build-from-source chrislupp/tools/<formula>
brew test chrislupp/tools/<formula>
```

See Homebrew's guide to
[creating and maintaining a tap](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap)
for additional details.
