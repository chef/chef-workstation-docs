+++
title = "Test Kitchen"
draft = false


[menu]
  [menu.tools]
    title = "About Test Kitchen"
    identifier = "tools/test_kitchen/kitchen.md About Test Kitchen"
    parent = "tools/test_kitchen"
    weight = 10
+++

Use [Test Kitchen](https://kitchen.ci/) to automatically test cookbooks
across any combination of platforms and test suites:

- Test suites are defined in a `kitchen.yml` file. See the
    [configuration](/tools/kitchen/config_yml_kitchen/) documentation for options
    and syntax information.
- Supports cookbook testing across many cloud providers and
    virtualization technologies.
- Uses a comprehensive set of operating system base images from Chef's
    [Bento](https://github.com/chef/bento) project.

The key concepts in Test Kitchen are:

- A platform is the operating system or target environment on which a cookbook is to be tested
- A suite is the Chef Infra Client configuration, a Policyfile or run-list, and (optionally) node attributes
- An instance is the combination of a specific platform and a specific suite, with each instance being assigned an auto generated name
- A driver is the lifecycle that implements the actions associated with a specific instance---create the instance, do what's needed to converge on that instance (such as installing Chef Infra Client, uploading cookbooks, and starting a Chef Infra Client run), setup anything else needed for testing, verify one (or more) suites post-converge, and then destroy that instance
- A provisioner is the component on which the Chef Infra Client code will be run, either using chef-zero or chef-solo with the `chef_zero` and `chef_solo` provisioners, respectively

## Bento

{{< readfile file="content/reusable/md/bento.md" >}}

## Drivers

{{< readfile file="content/reusable/md/test_kitchen_drivers.md" >}}

## Validation with Chef InSpec

Test Kitchen will create a VM or cloud instance, install Chef Infra
Client to that system, and converge Chef Infra Client with your local
cookbook. Once this is complete, you will want to perform automated
validation against the infrastructure you have built to validate its
configuration. Test Kitchen allows you to run Chef InSpec tests against your
converged cookbook for easy local validation of your infrastructure.

## kitchen (executable)

{{< readfile file="content/reusable/md/ctl_kitchen_summary.md" >}}

{{< note >}}

For more information about the `kitchen` command line tool, see
[kitchen](/tools/kitchen/ctl_kitchen/).

{{< /note >}}

## kitchen.yml

{{< readfile file="content/reusable/md/test_kitchen_yml.md" >}}

{{< note >}}

For more information about the `kitchen.yml` file, see
[kitchen.yml](/tools/kitchen/config_yml_kitchen/).

{{< /note >}}

### Syntax

{{< readfile file="content/reusable/md/test_kitchen_yml_syntax.md" >}}

### Work with proxies

{{< readfile file="content/reusable/md/test_kitchen_yml_syntax_proxy.md" >}}

## Additional information

For more information about test-driven development and Test Kitchen, see the kitchen.ci website:

- [kitchen.ci](https://kitchen.ci/)
- [Getting Started with Test Kitchen](https://kitchen.ci/docs/getting-started/introduction/)
