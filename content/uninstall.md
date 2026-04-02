+++
title = "Uninstall Chef Workstation and its tools"

[menu.uninstall]
title = "Uninstall"
identifier = "uninstall"
weight = 50
+++

The page documents how to uninstall Chef Workstation and its component tools.

## Uninstall Chef Workstation

To uninstall Chef Workstation, use the [`hab pkg uninstall`](https://docs.chef.io/habitat/habitat_cli/#hab-pkg-uninstall) command:

```sh
hab pkg uninstall chef/chef-workstation
```

## Uninstall Chef Workstation component packages

To uninstall a Workstation tool, use the [`hab pkg uninstall`](https://docs.chef.io/habitat/habitat_cli/#hab-pkg-uninstall) command:

```sh
hab pkg uninstall <PACKAGE_IDENT>
```

Replace `<PACKAGE_IDENT>` with one of the following packages:

- `chef/berkshelf`
- `chef/chef-cli`
- `chef/chef-infra-client`
- `chef/chef-test-kitchen-enterprise`
- `chef/chef-vault`
- `chef/cookstyle`
- `chef/fauxhai`
- `chef/knife`
- `chef/ohai`

## Uninstall a specific package version

You can uninstall a specific package version. For example:

```sh
hab pkg uninstall <PACKAGE_IDENT>
```

Replace `<PACKAGE_IDENT>` with one of the following:

- the package and version, for example `chef/<PACKAGE>/<VERSION>`.
- the package version and build, for example `chef/<PACKAGE>/<VERSION>/<BUILD_TIMESTAMP>`
