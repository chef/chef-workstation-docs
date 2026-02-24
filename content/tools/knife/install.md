+++
title = "Install Knife"

[menu.workstation]
title = "Install"
identifier = "workstation/knife/install"
parent = "workstation/knife"
weight = 20
+++

Knife is included as a component of Chef Workstation, but you can also install it as a standalone package.
The Knife standalone installation doesn't include the Knife cloud provider plugins (knife-ec2, knife-google, knife-windows).
For that reason, Progress Chef recommends installing Chef Workstation, which includes Knife and the Knife cloud provider plugins.

If you want to install Knife as a standalone component, follow the steps below.

## Requirements

Knife has the following requirements:

- Supported on Linux (Ubuntu 18.04+, CentOS 7+, RHEL 7+), macOS 10.15+, or Windows 10/Server 2016+
- Chef Habitat 1.6.0 or later installed
- Internet connectivity for package download and bootstrapping remote nodes
- SSH or WinRM to manage remote nodes

## Install the Knife standalone package

To install the Knife standalone package, follow these steps:

1. Install Knife:

    ```sh
    sudo hab pkg install chef/knife --channel unstable --binlink --force
    ```

1. Optional: After installation, verify Knife is installed and working:

    ```sh
    knife --version
    ```

## Next steps

- [Configure Knife](/configure/#configure-knife)
- [Add a license](/license)
