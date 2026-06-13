+++
title = "knife-ec-backup plugin"


[menu]
  [menu.tools]
    title = "knife-ec-backup"
    identifier = "tools/knife/plugins/knife-ec-backup"
    parent = "tools/knife/plugins"
+++

<!-- cspell:words useracl KEYPATH -->

The `knife-ec-backup` plugin backs up and restores the data in a Chef Infra Server installation, including all organizations, users, nodes, cookbooks, roles, and associated ACLs.
Use it before server migrations, version upgrades, or to create point-in-time snapshots of your Chef Infra Server.

## How knife ec backup works

`knife ec backup` downloads all users and user ACLs first, then iterates through every organization and downloads org-level objects using the Chef Infra Server REST API.

The backup writes everything to a directory tree under `<DIRECTORY>/users/` and `<DIRECTORY>/organizations/<ORG>/`.
If `--with-user-sql` or `--with-key-sql` is set, the command connects directly to PostgreSQL and writes `key_dump.json` and `key_table_dump.json` alongside the backup.

## Install knife-ec-backup

You can install knife-ec-backup as a Ruby gem or as a Habitat package.

Install knife-ec-backup as a Ruby gem:

```shell
gem install knife-ec-backup
```

Install knife-ec-backup as a Habitat package:

```bash
hab pkg install chef/knife-ec-backup -bf
```

{{< note >}}

The `-bf` options binlink the `knife-ec-backup` binary into a system-wide directory in your `PATH` (for example, `/bin` or `/usr/local/bin`).
You can then run `knife-ec-backup` directly from your shell.

{{< /note >}}

## Syntax

If you've installed `knife-ec-backup` as a Ruby gem or binlinked the Habitat package:

```shell
knife ec backup <DIRECTORY>
```

If you've installed `knife-ec-backup` as a Habitat package and didn't binlink it, execute it using the Habitat CLI and the full package name:

```shell
hab pkg exec chef/knife-ec-backup knife ec backup <DIRECTORY>
```

### Options and flags

`--concurrency <THREADS>`
: Maximum number of simultaneous API requests (default: 10).

`--dry-run`
: Report what actions would be taken without performing any.

`--error-log-dir <PATH>`
: Directory where errors are logged during the operation.

`--only-org <ORG>`
: Limit the operation to a single named organization.
  By default, all organizations are included.

`--purge`
: Sync deletions from the backup source to the restore destination.

`--secrets-file <PATH>`
: Path to `private-chef-secrets.json` (default: `/etc/opscode/private-chef-secrets.json`).

`--skip-frozen-cookbook-status`
: Skip writing a `status.json` file for each cookbook.
  Use this when you don't want to persist a cookbook's frozen status across restores.

`--skip-useracl`
: Skip downloading or restoring user ACLs.
  Required for Enterprise Chef 11.0.2 and earlier.

`--skip-version-check`
: Skip the Chef Infra Server version check and all autoconfigured options.

`--sql-host <HOSTNAME>`
: PostgreSQL hostname (default: `localhost`).

`--sql-password <PASSWORD>`
: PostgreSQL password.

`--sql-port <PORT>`
: PostgreSQL port (default: `5432`).

`--sql-user <USERNAME>`
: PostgreSQL user for the `opscode_chef` database.

`--webui-key <KEYPATH>`
: Path to the WebUI private key.
  Defaults to reading from the secrets store, `/etc/opscode/webui_priv.pem`, or the Automate path.

`--with-key-sql`
: Export rotated key data from the PostgreSQL `keys` table.
  Required for Chef Infra Server 12 and later when keys have been rotated.

`--with-user-sql`
: Export user data directly from the PostgreSQL database.
  Required to correctly preserve user passwords and keys.

## Examples

Use the following examples to back up Chef Infra Server data for common scenarios.

### Back up all organizations

To create a full backup of all organizations and global objects in a local directory, run:

```shell
knife ec backup /var/backups/chef-server
```

### Back up a single organization

To back up only one organization, pass the organization name with `--only-org`:

```shell
knife ec backup /var/backups/chef-server --only-org org-name
```

### Back up with PostgreSQL user and key data

To include user and key-table exports from PostgreSQL, add `--with-user-sql` and `--with-key-sql`:

```shell
knife ec backup /var/backups/chef-server --with-user-sql --with-key-sql \
  --sql-user opscode_chef --sql-password <PASSWORD>
```

### Back up and purge deleted objects

To remove objects from the destination that no longer exist on the source server, use `--purge`:

```shell
knife ec backup /var/backups/chef-server --purge
```

### Create a full backup

Create a full backup using required authentication and key flags:

```bash
knife ec backup backup_$(date '+%Y%m%d%H%M%s') \
  --webui-key /etc/opscode/webui_priv.pem \
  --with-key-sql \
  -s https://chef.example.com \
  -u pivotal \
  -k /etc/opscode/pivotal.pem
```

## More information

- [knife-ec-backup GitHub repository](https://github.com/chef/knife-ec-backup/)
- [knife tidy](/tools/knife/plugins/knife_tidy/)
