+++
title = "Upgrade Chef Workstation and its components"

[menu.upgrade]
title = "Upgrade"
identifier = "upgrade"
+++

Chef Workstation 26.1 and later uses native installers for Debian, RPM, Windows, and macOS.
To upgrade, install the latest version for your operating system.

## Upgrade on Debian-based systems

To upgrade Chef Workstation on a Debian-based system, follow these steps:

1. Download the latest Debian-based installer using one of the following methods:

   - Download using `wget`:

     ```shell
     wget -O "chef-workstation-enterprise-<VERSION>-linux.deb" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=deb&v=<VERSION>"
     ```

   - Download using `curl`:

     ```shell
     curl -o "chef-workstation-enterprise-<VERSION>-linux.deb" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=deb&v=<VERSION>"
     ```

   Replace:
   - `<VERSION>` with the version number to upgrade to.
   - `<LICENSE_ID>` with your Chef license ID.

1. Install the new version:

   ```shell
   sudo dpkg -i chef-workstation-enterprise-<VERSION>_amd64.deb
   ```

   Replace `<VERSION>` with the version number of the downloaded package.

## Upgrade on RPM-based systems

To upgrade Chef Workstation on an RPM-based system, follow these steps:

1. Download the latest RPM-based installer using one of the following methods:

   - Download using `wget`:

     ```shell
     wget -O "chef-workstation-enterprise-<VERSION>-linux.rpm" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=rpm&v=<VERSION>"
     ```

   - Download using `curl`:

     ```shell
     curl -o "chef-workstation-enterprise-<VERSION>-linux.rpm" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=rpm&v=<VERSION>"
     ```

   Replace:
   - `<VERSION>` with the version number to upgrade to.
   - `<LICENSE_ID>` with your Chef license ID.

1. Install the new version:

   ```shell
   sudo dnf install chef-workstation-enterprise-<VERSION>.x86_64.rpm
   ```

   Alternatively:

   ```shell
   sudo rpm -Uvh chef-workstation-enterprise-<VERSION>.x86_64.rpm
   ```

   Replace `<VERSION>` with the version number of the downloaded package.

## Upgrade on Windows

To upgrade Chef Workstation on Windows, follow these steps:

1. Download the latest Windows installer:

   ```powershell
   Invoke-WebRequest -Uri "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=windows&pm=msi&v=<VERSION>" -OutFile "chef-workstation-enterprise-<VERSION>_x86_64.msi"
   ```

   Replace:
   - `<VERSION>` with the version number to upgrade to.
   - `<LICENSE_ID>` with your Chef license ID.

1. Install the new version:

   ```powershell
   msiexec /i chef-workstation-enterprise-<VERSION>_x86_64.msi
   ```

   Replace `<VERSION>` with the version number of the downloaded package.

## Upgrade on macOS

To upgrade Chef Workstation on macOS, follow these steps:

1. Download the latest macOS installer:

   ```shell
   curl -o "chef-workstation-enterprise-<VERSION>-darwin.dmg" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=aarch64&p=mac_os_x&pm=dmg&v=<VERSION>"
   ```

   Replace:
   - `<VERSION>` with the version number to upgrade to.
   - `<LICENSE_ID>` with your Chef license ID.

1. Mount the DMG:

   ```shell
   hdiutil attach chef-workstation-enterprise-<VERSION>-darwin.dmg
   ```

1. Install the new version:

   ```shell
   sudo installer -pkg /Volumes/Chef\ Workstation\ Enterprise/chef-workstation-enterprise-<VERSION>.pkg -target /
   ```

   The installer will automatically detect and upgrade your existing installation.

   Replace `<VERSION>` with the version number of the downloaded package.

1. Unmount the DMG:

   ```shell
   hdiutil detach /Volumes/Chef\ Workstation\ Enterprise
   ```

1. Reload your shell to update binaries:

   ```shell
   exec zsh
   ```

## Next steps

- [Set up Workstation](/set_up/)
- [Add a license](/license/)

## See also

- [Install Chef Workstation](install)
- [Uninstall Chef Workstation](uninstall)
