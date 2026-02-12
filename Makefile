
bundle:
	npm install

clean_all:
	rm -rf node_modules
	rm -rf resources/
	rm -rf public/
	hugo mod clean

serve: bundle
	hugo server --buildDrafts --noHTTPCache --buildFuture

metrics: bundle
	hugo --gc --minify --enableGitInfo --templateMetrics --templateMetricsHints

nodrafts: bundle
	hugo server --noHTTPCache --buildFuture

production: bundle
	hugo server --noHTTPCache --environment production

# Override the theme in the _vendor directory and build using locally sourced theme defined in hugo.work file.
# See https://gohugo.io/hugo-modules/use-modules/#module-workspaces
test_theme: bundle
	HUGO_MODULE_WORKSPACE=hugo.work hugo server --buildDrafts --noHTTPCache --buildFuture --ignoreVendorPaths "github.com/chef/chef-docs-theme"

test_branch_deploy: bundle
	hugo server --noHTTPCache --baseURL http://localhost:1313/workstation/version/

serve_ignore_vendor: bundle
	hugo server --buildDrafts --noHTTPCache --buildFuture --ignoreVendorPaths github.com/**

lint: bundle
	hugo -D

update_theme:
	hugo mod get -u github.com/chef/chef-docs-theme
	rm -rf _vendor node_modules
	hugo mod tidy
	hugo mod vendor
	hugo mod npm pack
	npm install

## See:
## - https://cspell.org/docs/getting-started/
## - https://cspell.org/configuration/
## - and cspell.yaml file.
spellcheck:
	cspell --no-progress "**/*.{md, html, js, yml, yaml, toml, json}"
