+++
title = "Install Chef Workstation"
draft = false


[menu]
  [menu.install]
    title = "Install"
    identifier = "install.md Install Chef Workstation"
    weight = 10
+++

{{< readfile file="/content/reusable/md/workstation_modularize.md" >}}

## System requirements

Chef Workstation 26 has the following requirements:

- Linux x86-64 (64-bit) systems only
- Chef Habitat 1.6.0 or later installed
- Minimum 2GB available disk space for installation
- Internet connectivity for package downloads (or access to internal Habitat Builder)

## Prerequisites

We use Chef Habitat to distribute and install Chef Workstation and its components.
See the following guides to install and configure Chef Habitat:

- [Install Chef Habitat](https://docs.chef.io/habitat/install_habitat/)
- [Create a Chef Habitat Builder profile](https://docs.chef.io/habitat/builder_profile/)

## Install Chef Workstation

To install Chef Workstation, follow these steps:

1. Install the Chef Workstation Habitat package:

    ```sh
    sudo hab pkg install --binlink --force chef/chef-workstation --channel unstable
    ```

    - `--binlink`: Creates symbolic links in `/bin` for all included tools, making them accessible system-wide
    - `--force`: Overwrites any existing binlinks from previous installations
    - `--channel unstable`: Specifies the unstable channel where releases are published

    The installation process downloads the package and all dependencies, creates necessary binlinks, and configures the environment.
    This may take several minutes depending on your network connection.

1. Optional: Verify that Chef Workstation and its tools are installed:

    ```sh
    chef-workstation -v
    ```

    Chef Workstation returns a list of installed packages and their versions.

1. Optional: You can also verify each individual tool:

    ```sh
    chef-cli --version
    knife --version
    kitchen --version
    berks --version
    cookstyle --version
    ohai --version
    chef-vault --version
    inspec --version
    ```

## Install Chef Workstation tools

The following applications are included with Chef Workstation,
but they can be installed as standalone applications.

Follow these instructions to install a Workstation tool.

1. Install a package using [`hab pkg install`](https://docs.chef.io/habitat/habitat_cli/#hab-pkg-install):

    ```sh
    sudo hab pkg install <PACKAGE_IDENT> --channel unstable --binlink --force
    ```

    Replace `<PACKAGE_IDENT>` with the package identifier:

    - `chef/berkshelf`
    - `chef/chef-cli`
    - `chef/chef-infra-client`
    - `chef/chef-test-kitchen-enterprise`
    - `chef/chef-vault`
    - `chef/cookstyle`
    - `chef/fauxhai`
    - `chef/inspec`
    - `chef/knife`
    - `chef/ohai`

    The `--binlink --force` options overwrite any existing package symbolic links in the system's PATH directory with the new version so you can run it directly in the command line.

1. Verify that the correct version runs:

    ```sh
    berks -v
    chef-cli -v
    chef-client -v
    chef-client -v
    chef-vault <args>
    cookstyle -v
    fauxhai -v
    knife -v
    ohai -v
    ```

## Troubleshooting

### Binlinks not found

If commands aren't found after installation, verify that Chef Habitat created the binlinks:

```sh
ls -la /bin | grep chef
```

If binlinks are missing, recreate them:

```sh
sudo hab pkg binlink --force chef/chef-workstation
```

### Permission errors

Ensure you're running installation commands with `sudo` for system-wide access.

### Habitat channel issues

If the package can't be found, verify channel availability:

```sh
hab pkg search chef/chef-workstation --channel unstable
```

## Next step

- [Set up Workstation](set_up)
- [Add a license](license)

## More information

- [Chef Habitat documentation](https://docs.chef.io/habitat/)
- [Upgrade Chef Workstation 26 and its components](upgrade)
