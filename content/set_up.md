+++
title = "Set up Chef Workstation"
draft = false

[menu]
  [menu.set_up]
    title = "Set up"
    identifier = "setup.md Set Up Chef Workstation"
    weight = 10
+++

This guide walks you through setting up Chef Workstation on your computer:

- [Set up your chef-repo](#set-up-your-chef-repo) for storing your cookbooks
- [Configure your Chef credentials](#configure-your-user-credentials)

## Prerequisites

- [Chef Workstation installed]({{< relref "install.md" >}})
- A running instance of Chef Infra Server.
- The `CLIENT.PEM` file supplied by your Chef administrator.

## About the chef-repo

If you're setting up Chef for the very first time in your organization, you need a chef-repo. The chef-repo is a directory on your workstation that stores everything you need to define your infrastructure with Chef Infra:

- Cookbooks (including recipes, attributes, custom resources, libraries, and templates)
- Data bags
- Policyfiles

Treat the chef-repo like source code and synchronize it with a version control system, such as Git.

Use the `chef` and `knife` commands to upload data from the chef-repo to Chef Infra Server. Chef Infra Client then uses that data to manage registered nodes, applying the correct cookbooks, Policyfiles, and settings.

### Set up your chef-repo

To set up your chef-repo, use the [chef generate repo]({{< relref "ctl_chef.md#chef-generate-repo" >}}) command. For example, to create a repository called `chef-repo`:

```bash
chef generate repo chef-repo
```

## About Chef credentials

The first time you run Chef Workstation, it creates a `.chef` directory in your home directory to store your credentials and configuration.

For more information about configuring credentials, including creating credentials for multiple Chef Infra Server instances or organizations, see the [Set up knife documentation](/tools/knife/set_up/).

### Credentials for administrators and users

If you're setting up Chef Workstation **as a Chef Infra Server administrator**, manage users with the [Chef Infra Server CLI](https://docs.chef.io/server/ctl_chef_server/#user-management). When you create a new user, Chef Infra Server generates a user-specific RSA client key that you must share securely with that user.

If you're setting up Chef Workstation **as a Chef user**, you need a client private key created by your server administrator. The client private key is an RSA private key in `.pem` format.

### Configure your user credentials

To configure knife to communicate with Chef Infra Server, you need the following from your Chef administrator:

- `chef_server_url`: the full URL to your Chef Infra Server including the organization.
- `client_name`: the username that you'll use to authenticate with Chef Infra Server.
- Your private key PEM file that you'll use to authenticate with Chef Infra Server (for example, `username.pem`).

To configure your user credentials, follow these steps:

1. Set up your client private key.

    Your Chef administrator provides you with a `client.pem` file (or similar). This file is an RSA private key that authenticates all communication between Chef Workstation and Chef Infra Server.

    Copy this file to the `~/.chef/` directory (on macOS or Linux) or `C:\Users\<USERNAME>\.chef\` directory (on Windows). Use one of the following commands:

    - On macOS and Linux:

      ```bash
      cp ~/Downloads/<USERNAME>.pem ~/.chef/
      ```

    - On Windows:

      ```powershell
      Copy-Item -Path C:\Users\<USERNAME>\Downloads\<USERNAME>.pem -Destination C:\Users\<USERNAME>\.chef\
      ```

1. Configure knife to connect to Chef Infra Server.

    You can use the interactive `knife configure` command or manually create a credentials file.

    - To have knife prompt you for your Chef Infra Server credentials and generate a credentials file, run:

      ```sh
      knife configure
      ```

    - To manually create a credentials file, follow these steps:

      1. Create the `credentials` file:

         On macOS or Linux, run:

         ```sh
         mkdir -p ~/.chef
         touch ~/.chef/credentials
         ```

         On Windows (PowerShell), run:

         ```powershell
         New-Item -ItemType Directory -Path "$HOME/.chef" -Force
         New-Item -ItemType File -Path "$HOME/.chef/credentials" -Force
         ```

      1. Add your Chef Infra Server credentials to the `credentials` file:

         ```toml
         [default]
         chef_server_url = "<CHEF_SERVER_URL>"
         client_name = "<USERNAME>"
         client_key = "<CLIENT_CERT>"
         ```

         Replace the following:

         - <CHEF_SERVER_URL> with your Chef Infra Server URL and organization name. For example, `https://chef-server.example.com/organizations/org-name`.
         - `<USERNAME>` with your Chef Infra Server username.
         - <CLIENT_CERT> with the path to your client certificate file. For example, `~/.chef/certificate_file.pem` or `C:/Users/<USERNAME>/.chef/<USERNAME>.pem`

    For more information about configuring credentials, including creating credentials for multiple Chef Infra Server instances or organizations, see the [Set up knife documentation](/tools/knife/set_up/).

1. Verify that Chef Workstation can connect to Chef Infra Server:

    ```bash
    knife client list
    ```

    The command returns a list of Chef Infra Client nodes similar to:

    ```bash
    chef_machine
    registered_node
    ```

1. Optional: Fetch the Chef Infra Server SSL certificates.

    If your Chef Infra Server deployment is configured to use a self-signed certificate, download the Chef Infra Server TLS/SSL certificate and save it locally in `.chef/trusted_certs`:

    ```sh
    knife ssl fetch
    ```

    Verify the certificates:

    ```sh
    knife ssl check
    ```

    Chef Infra verifies the security of all requests made to Chef Infra Server from tools like knife and Chef Infra Client. The certificate generated during the installation of Chef Infra Server is self-signed, meaning no certificate authority (CA) has signed it. You must download this certificate to every machine from which knife or Chef Infra Client will make requests to Chef Infra Server.

    For more information about how knife and Chef Infra Client use SSL certificates generated by Chef Infra Server, see [Chef Infra Client's SSL certificates documentation](https://docs.chef.io/client/latest/security/chef_client_security/#ssl-certificates).

## Next step

- [Add a Chef license](license)
- [Get started with Chef cookbook development using Chef Workstation](get_started)

## More information

- [Set up knife documentation](/tools/knife/set_up/)
- [knife `config.rb` settings documentation](/tools/knife/config_rb)
- [`knife ssl fetch` documentation](/tools/knife/knife_ssl_fetch/)
- [`knife ssl check` documentation](/tools/knife/knife_ssl_check/)
- [LearnChef tutorials](https://www.chef.io/training/tutorials)
