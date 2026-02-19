<!-- markdownlint-disable-next-line MD002 -->
# Chef Workstation docs

Documentation for Chef Workstation.

## Versions

The content in this repo is versioned using different Git branches.

When we get version numbers for those releases, that content will be moved into `release-<VERSION_NUMBER>` branches.

### Configuration

The version is configured in two ways:

- the branch name, which uses the following pattern `release-<MAJ>.<MIN>`
- the version number, which is set by the [`product_version` parameter in the root `_index.md` file](https://github.com/chef/chef-workstation-docs/blob/main/content/_index.md?plain=1#L7).

## Style guide

See the [Chef Documentation style guide](https://docs.chef.io/community/style/) for writing and formatting guidance.
If you don't find style guidance in the Chef Documentation Style Guide, use [Google's Style Guide](https://developers.google.com/style) or [Microsoft's Style Guide](https://learn.microsoft.com/en-us/style-guide/welcome/).

### Shortcodes

Use [shortcodes](https://docs.chef.io/community/style/shortcodes/) to include content and format pages and text.

### Images

Add images to `static/images/`.

#### Alt text

All images must have alt text. See the [W3C WAI guidelines for alt text](https://www.w3.org/WAI/tutorials/images/).

Example:

```md
![alt text](static/images/image.png)
```

#### Images of text

Don't add images of text, for example, images of configuration files, code samples, or terminal outputs.
People who use screen readers can't read an image of text and users may want to copy and paste that text on their workstation.

Add code examples, terminal outputs, or config files as a code block.

## Local development

### Requirements

- [Hugo](https://gohugo.io/) 0.123.4 or greater
- [Node](https://www.nodejs.com) 10.0.0 or higher
- [NPM](https://www.npmjs.com/) 5.6.0 or higher
- [Go](https://golang.org/dl/) 1.22 or higher
- [Dart Sass](https://sass-lang.com/dart-sass/) 1.72 or higher

To install on Windows, run:

```ps1
choco install hugo-extended nodejs golang sass
```

To install on macOS, run:

```sh
brew install hugo node go sass/sass/sass
```

To install on Ubuntu, run:

- `apt install -y build-essential`
- `snap install node --classic --channel=12`
- `snap install hugo --channel=extended`
- `snap install dart-sass`

### Build and preview the docs locally

- Run `make serve`
- go to [http://localhost:1313](http://localhost:1313)

### Editing tools

Use the following extensions for editing in VSCode:

- [Code Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker)
- [Markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)
- [Trailing Spaces](https://marketplace.visualstudio.com/items?itemName=shardulm94.trailing-spaces)
- [Vale](https://marketplace.visualstudio.com/items?itemName=ChrisChinchilla.vale-vscode)

#### Build and preview using Netlify CLI

You can use the [Netlify CLI](https://docs.netlify.com/cli/local-development/) to build and preview documentation locally.
This is useful for previewing redirects or other settings configured in the `netlify.toml` file.

Requirements:

- all the requirements for building this site locally
- [Netlify CLI](https://docs.netlify.com/cli/get-started/#installation)

Run `netlify dev` to preview the site using the Netlify CLI.

## Netlify deployment

Netlify deploys content in the `main` branch of this repository to [<https://chef-workstation.netlify.app/>](https://chef-workstation.netlify.app/).

### Versioning

1. Create a branch of this repo in the following format: `release-<MAJ>.<MIN>`.

1. On the [Netlify site](https://app.netlify.com) add a [branch deploy](https://docs.netlify.com/site-deploys/overview/#set-up-a-branch-deploy-for-specific-branches) for that branch in the site configuration.

1. Push the branch up to GitHub. Netlify automatically builds a deployment of that branch at `release-<MAJ>.<MIN>--chef-workstation.netlify.app/workstation/<MAJ>.<MIN>`.
   Any changes merged into that branch are automatically deployed.
