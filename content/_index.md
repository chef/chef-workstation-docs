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

Chef Workstation Enterprise is the next evolution of Chef Workstation, designed to simplify installation, upgrades, and component management.
It includes essential tools such as Chef CLI, Test Kitchen, Knife, and Chef InSpec to help you build, test, and manage your infrastructure.
To get started, [install Chef Workstation](/install/) and follow the cookbook development workflow below.

### Cookbook development workflow

Chef Infra defines a common workflow for cookbook development:

1. Create a skeleton cookbook by running `chef generate cookbook MY_COOKBOOK_NAME`. This generates a cookbook with a single recipe and testing configuration for Test Kitchen with Chef InSpec.
1. Write cookbook recipes or resources and lint and debug them with Cookstyle and Test Kitchen. Making your own cookbooks is an iterative process where you develop, test, find and fix bugs, and then develop and test some more. A text editor---Visual Studio Code, Atom, vim, or any other preferred text editor---is the only tool that you need to author your cookbooks.
1. Test in acceptance. Test your work in an environment that matches your production environment.
1. Deploy your cookbooks to the production environment, but only after they pass all the acceptance tests and are verified to work in the desired manner.
