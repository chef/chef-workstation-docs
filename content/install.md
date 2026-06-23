+++
title = "Chef Workstation install guide"
draft = false


[menu]
  [menu.install]
    title = "Install"
    identifier = "install.md Install Chef Workstation"
    weight = 10
+++

{{< readfile file="/content/reusable/md/workstation_modularize.md" >}}

Chef Workstation 26.1 installers are available for Windows, Debian, and RPM-based Linux distributions.

You can download and install pre-built `.msi`, `.deb`, or `.rpm` packages using your existing package management tools.

## Supported platforms

Chef Workstation is supported on the following platforms:

- Windows x86-64
- Linux x86-64

## Prerequisites

This installation process has the following prerequisites:

- Chef Client isn't installed on the target system.
- On Windows systems, tar is installed.
- On Debian-based systems, the `dpkg` package manager is installed.
- On RPM-based systems, `rpm` and either `dnf` or `yum` are installed. For Amazon Linux 2, use `rpm` and `yum`.
- You have a valid Progress Chef license key.
- The target system is connected to the internet.

## Install Chef Workstation

### Install Chef Workstation on Debian-based systems

To install Chef Workstation on a Debian-based system, follow these steps:

1. Download the Debian-based installer using one of the following methods:

   - Download using `wget`:

     ```sh
     wget -O "chef-workstation-enterprise-<VERSION>-linux.deb" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=deb&v=<VERSION>"
     ```

   - Download using `curl`:

     ```sh
     curl -o "chef-workstation-enterprise-<VERSION>-linux.deb" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=deb&v=<VERSION>"
     ```

   Replace:
   - `<VERSION>` with the version number to install.
   - `<LICENSE_ID>` with your Chef license ID.

1. Install Chef Workstation:

   ```sh
   sudo dpkg -i chef-workstation-enterprise-<VERSION>_amd64.deb
   ```

   Replace `<VERSION>` with the version number of the downloaded package, for example `chef-workstation-enterprise-26.1.0-1_amd64.deb`.

### Install Chef Workstation on RPM-based systems

To install Chef Workstation on an RPM-based system, follow these steps:

1. Download the RPM-based installer using one of the following methods:

   - Download using `wget`:

     ```sh
     wget -O "chef-workstation-enterprise-<VERSION>-linux.rpm" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=rpm&v=<VERSION>"
     ```

   - Download using `curl`:

     ```sh
     curl -o "chef-workstation-enterprise-<VERSION>-linux.rpm" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=rpm&v=<VERSION>"
     ```

   Replace:
   - `<VERSION>` with the version number to install.
   - `<LICENSE_ID>` with your Chef license ID.

1. Install Chef Workstation using one of the following methods:

   - Install using `rpm`:

     ```sh
     sudo rpm -Uvh chef-workstation-enterprise-<VERSION>.x86_64.rpm
     ```

   - Install using `dnf`:

     ```sh
     sudo dnf install ./chef-workstation-enterprise-<VERSION>.x86_64.rpm
     ```

   - For Amazon Linux 2 or systems using `yum`:

     ```sh
     sudo yum install ./chef-workstation-enterprise-<VERSION>.x86_64.rpm
     ```

   Replace `<VERSION>` with the version number of the downloaded package, for example `chef-workstation-enterprise-26.1.0-1.x86_64.rpm`.

### Install Chef Workstation on Windows

To install Chef Workstation on Windows, follow these steps:

1. Download the installer in an elevated PowerShell session:

   ```powershell
   Invoke-WebRequest -Uri "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=windows&pm=msi&v=<VERSION>" -OutFile "chef-workstation-enterprise-<VERSION>-windows.msi"
   ```

   Replace:
   - `<VERSION>` with the version number to install.
   - `<LICENSE_ID>` with your Chef license ID.

1. Install Chef Workstation using one of the following methods:

   - Run the following command in an elevated PowerShell or Command Prompt session:

     ```powershell
     msiexec /i chef-workstation-enterprise-<VERSION>-x64.msi /qn
     ```

   - Double-click the `.msi` file and follow the on-screen installation wizard.

   Replace `<VERSION>` with the version number of the downloaded package, for example `chef-workstation-enterprise-26.1.0-1_x64.msi`.

## Verify the installation

After installation, verify that Chef Workstation is installed correctly by running one of the following commands:

```sh
chef-workstation -v
```

or

```sh
chef -v
```

The output displays the installed Chef Workstation version.

## Upgrade Chef Workstation

To upgrade Chef Workstation to a newer version:

1. Download and install the new version using the steps for your platform on this page.

## Next steps

- [Set up Workstation](set_up)
- [Add a license](license)
- Optional: [Get started with Chef Workstation](get_started)

## More information

- [Chef Download API documentation](https://docs.chef.io/download/)
