+++
title = "About Chef Workstation"
draft = false


[menu]
  [menu.about]
    title = "About Chef Workstation"
    identifier = "about_workstation.md About Chef Workstation"
    weight = 10
+++

<!-- markdownlint-disable-file MD033 -->

{{< readfile file="content/reusable/md/chef_workstation.md" >}}

## Get started

Chef Workstation Enterprise represents the next evolution of Chef Workstation. This new distribution model is designed to simplify releases and offer greater flexibility when upgrading or installing individual components. By using Habitat as its underlying package management system, Chef Workstation Enterprise allows organizations to maintain precise control over component versions while making installation and upgrades more straightforward.
The transition from Chef Workstation to Chef Workstation Enterprise introduces several architectural improvements that address common challenges faced by enterprise users. These include independent component versioning, support for multiple versions running side by side, and simplified update workflows.
The new Chef Workstation also includes essential tools such as chef-cli, Test Kitchen, Knife, and others, helping users install, manage, and upgrade their environments with greater ease.
Chef Workstation Enterprise is built to work seamlessly with Chef Infra, a powerful automation framework for managing infrastructure at scale. Chef Infra makes it easy to deploy and manage servers and applications across physical, virtual, or cloud environments. A typical setup includes one or more Chef Workstation installations, a central Chef server, and nodes managed by the Chef Infra Client. Configuration is defined using cookbooks and recipes, which the client applies to each node to ensure consistency.

- [An Overview of Chef Infra](https://docs.chef.io/chef_overview/)
- [Install Chef Workstation](/install/)

### Cookbook development workflow

Chef Infra defines a common workflow for cookbook development:

1. Create a skeleton cookbook by running `chef generate cookbook MY_COOKBOOK_NAME`. This generates a cookbook with a single recipe and testing configuration for Test Kitchen with Chef InSpec.
1. Write cookbook recipes or resources and lint and debug them with Cookstyle and Test Kitchen. Making your own cookbooks is an iterative process where you develop, test, find and fix bugs, and then develop and test some more. A text editor---Visual Studio Code, Atom, vim, or any other preferred text editor---is the only tool that you need to author your cookbooks.
1. Test in acceptance. Test your work in an environment that matches your production environment.
1. Deploy your cookbooks to the production environment, but only after they pass all the acceptance tests and are verified to work in the desired manner.

## Included tools and components

Chef Workstation includes the following fully integrated tools:

### Core development tools

- **Chef CLI (`chef-cli`)**: Primary command-line interface for Chef development workflows, providing unified access to common Chef operations
- **Chef Infra Client**: Latest release candidate of the Chef Infra Client, enabling infrastructure automation and configuration management
- **Knife**: Essential tool for interacting with Chef Infra Server, managing nodes, cookbooks, roles, and other Chef objects
- **Chef InSpec**: Latest release candidate of InSpec, enabling compliance and security testing.

### Testing and quality assurance

- **Chef Test Kitchen Enterprise**: Comprehensive testing framework for validating infrastructure code across multiple platforms and environments
- **Chef InSpec**: Compliance and security testing framework for auditing infrastructure and applications against security standards and regulations
- **Cookstyle**: Ruby and Chef cookbook linting tool that enforces style guidelines and best practices
- **Fauxhai**: Mock Ohai data generator for testing purposes, enabling rapid cookbook testing without requiring actual systems

### Dependency and secret management

- **Berkshelf**: Cookbook dependency manager that streamlines the process of managing and retrieving cookbook dependencies
- **Chef Vault**: Secure data management tool for encrypting and managing secrets within Chef workflows
- **Ohai**: System profiling tool that detects and reports system attributes for use in Chef recipes
