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
- [Create a Chef Habitat Builder profile](https://docs.chef.io/habitat/builder/saas/builder_profile/)

## Install Chef Workstation

Chef Workstation supports several installation methods to accommodate different deployment scenarios.
Installing the Latest Stable Version To install the most recent stable release from the default channel, execute the following command:

### Installing with Binary Linking (Recommended)

The recommended installation method includes binary linking, which creates symbolic links to the package binaries in your system PATH. This enables direct command execution without requiring the full Habitat exec syntax:

```shell
sudo hab pkg install chef/chef-workstation --binlink --force
```

### Installing from the Unstable Channel

For access to pre-release versions and the latest development builds, install from the unstable channel:

```shell
hab pkg install chef/chef-workstation --channel unstable
```

### Installing a Specific Version

When you need to install a particular version of Chef Workstation Enterprise , specify the version and timestamp in the package identifier:

```shell
hab pkg install chef/chef-workstation/<VERSION>/<TIMESTAMP>
```

For example, to install version 26.0.15 with timestamp 20260320102857:

```shell
hab pkg install chef/chef-workstation/26.0.15/20260320102857
```

### Post-Installation Verification

After completing the installation, verify that Chef Workstation is correctly installed by checking the version information:

```shell
chef-workstation -v
```

OR

```shell
chef -v
```

A successful installation will display output similar to the following:

```shell
Product Name: Chef Workstation
Product Version: 26.0.16

Default Installed Components:

Chef Infra Client Version: 19.2.12
Chef CLI Version: 6.1.29
Chef Test Kitchen Enterprise Version: 2.0.11
Berkshelf Version: 8.1.21
Ohai Version: 19.1.24
Fauxhai Version: 9.4.20
Chef Vault Version: 4.2.9
Cookstyle Version: 8.6.10
Chef InSpec Version: 7.0.107
```

Note: After installing a Habitat package on Windows, you need to add (use hab cli setup) C:\hab\bin to your system PATH so that binlinked commands (like knife, chef-cli, inspec) work smoothly from any terminal.

### Usage Guide

Chef Workstation provides two primary methods for executing the bundled tools. This section describes each approach and provides guidance on selecting the appropriate method for your use case.

### Method 1: Using Direct Executables with Binary Linking

Binary linking creates symbolic links to package executables in a system-wide location, allowing you to invoke tools directly without the Habitat exec prefix. This method provides a more familiar command-line experience similar to traditional installations.
To enable binary linking during the initial installation, include the binlink flag:

```shell
sudo hab pkg install chef/chef-workstation --binlink
```

If you have already installed Chef Workstation without binary linking, you can enable it afterwards:

```shell
sudo hab pkg binlink chef/chef-workstation
```

Once binary linking is enabled, you can invoke tools directly from the command line:

```shell
kitchen -v
chef-cli -v
chef-client --version
berks -v
inspec version
knife -v
```

### Method 2: Using Habitat Exec

The Habitat exec command provides explicit control over which package and version is used to execute a command. This method is recommended when you need to ensure a specific package version is used or when binary linking isn't available.
The general syntax for the Habitat exec command is as follows:

```shell
hab pkg exec chef/<package-name> <binary-name> <command>
```

The following table provides examples of common tool invocations using the Habitat exec method:

| Tool              | Command                                                    | Version Command       |
|-------------------|------------------------------------------------------------|-----------------------|
| Test Kitchen      | hab pkg exec chef/chef-test-kitchen-enterprise kitchen      | kitchen -v            |
| Chef CLI          | hab pkg exec chef/chef-cli chef-cli                        | chef-cli -v           |
| Chef Infra Client | hab pkg exec chef/chef-infra-client chef-client             | chef-client --version |
| Berkshelf         | hab pkg exec chef/berkshelf berks                          | berks -v              |
| Ohai              | hab pkg exec chef/ohai ohai                                | ohai --version        |
| Cookstyle         | hab pkg exec chef/cookstyle cookstyle                      | cookstyle -v          |
| Chef Vault        | hab pkg exec chef/chef-vault chef-vault                    | chef-vault -v         |
| Fauxhai           | hab pkg exec chef/fauxhai fauxhai                          | fauxhai -v            |
| Chef InSpec       | hab pkg exec chef/inspec inspec                            | inspec version        |
| Knife             | hab pkg exec chef/knife knife                              | knife -v              |

## Install Chef Workstation tools

The following applications are included with Chef Workstation,
but they can be installed as standalone applications.

Follow these instructions to install a Workstation tool.

1. Install a package using [`hab pkg install`](https://docs.chef.io/habitat/habitat_cli/#hab-pkg-install):

    ```sh
    sudo hab pkg install <PACKAGE_IDENT> --binlink --force
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
