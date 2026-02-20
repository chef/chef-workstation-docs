chef-shell is tool that's run using an Interactive Ruby (IRb) session.
chef-shell currently supports recipe and attribute file syntax, as well
as interactive debugging features. chef-shell has three run modes:


Standalone
: Default. No cookbooks are loaded, and the run-list is empty.

Solo
: chef-shell acts as a Chef Solo Client. It attempts to load the chef-solo configuration file at `~/.chef/config.rb` and any JSON attributes passed. If the JSON attributes set a run-list, it will be honored. Cookbooks will be loaded in the same way that chef-solo loads them. chef-solo mode is activated with the `-s` or `--solo` command line option, and JSON attributes are specified in the same way as for chef-solo, with `-j /path/to/chef-solo.json`.

Client
: chef-shell acts as a Chef Infra Client. During startup, it reads the Chef Infra Client configuration file from `~/.chef/client.rb` and contacts the Chef Infra Server to get the node's run_list, attributes, and cookbooks. Chef Infra Client mode is activated with the `-z` or `--client` options. You can also specify the configuration file with `-c CONFIG` and the server URL with `-S SERVER_URL`.
