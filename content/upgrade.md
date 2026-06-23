+++
title = "Upgrade Chef Workstation and its components"

[menu.upgrade]
title = "Upgrade"
identifier = "upgrade"
+++

Chef Workstation 26.1 and later are distributed as installers for Debian, RPM, and Windows.
To upgrade, install the latest version for your operating system.

## Upgrade on Debian-based systems

To upgrade Chef Workstation on a Debian-based system, follow these steps:

1. Download the latest Debian-based installer using one of the following methods:

   - Download using `wget`:

     ```sh
     wget -O "chef-workstation-enterprise-<VERSION>-linux.deb" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=deb&v=<VERSION>"
     ```

   - Download using `curl`:

     ```sh
     curl -o "chef-workstation-enterprise-<VERSION>-linux.deb" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=deb&v=<VERSION>"
     ```

   Replace:
   - `<VERSION>` with the version number to upgrade to.
   - `<LICENSE_ID>` with your Chef license ID.

1. Install the new version:

   ```sh
   sudo dpkg -i chef-workstation-enterprise-<VERSION>_amd64.deb
   ```

   Replace `<VERSION>` with the version number of the downloaded package.

## Upgrade on RPM-based systems

To upgrade Chef Workstation on an RPM-based system, follow these steps:

1. Download the latest RPM-based installer using one of the following methods:

   - Download using `wget`:

     ```sh
     wget -O "chef-workstation-enterprise-<VERSION>-linux.rpm" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=rpm&v=<VERSION>"
     ```

   - Download using `curl`:

     ```sh
     curl -o "chef-workstation-enterprise-<VERSION>-linux.rpm" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=rpm&v=<VERSION>"
     ```

   Replace:
   - `<VERSION>` with the version number to upgrade to.
   - `<LICENSE_ID>` with your Chef license ID.

1. Install the new version using one of the following methods:

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

   Replace `<VERSION>` with the version number of the downloaded package.

## Upgrade on Windows

To upgrade Chef Workstation on Windows, follow these steps:

1. Download the latest Windows installer:

   ```powershell
   Invoke-WebRequest -Uri "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=windows&pm=msi&v=<VERSION>" -OutFile "chef-workstation-enterprise-<VERSION>-x64.msi"
   ```

   Replace:
   - `<VERSION>` with the version number to upgrade to.
   - `<LICENSE_ID>` with your Chef license ID.

1. Install the new version:

   ```powershell
   msiexec /i chef-workstation-enterprise-<VERSION>-x64.msi /qn
   ```

   Replace `<VERSION>` with the version number of the downloaded package.

## Next steps

- [Set up Workstation](/set_up/)
- [Add a license](/license/)
