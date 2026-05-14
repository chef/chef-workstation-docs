+++
title = "knife-ec-backup plugin"


[menu]
  [menu.tools]
    title = "knife-ec-backup"
    identifier = "tools/knife/plugins/knife-ec-backup"
    parent = "tools/knife/plugins"
+++

The `knife-ec-backup` plugin backs up and restores the data in a Chef Infra Server installation, including all organizations, users, nodes, cookbooks, roles, and associated ACLs.
Use it before server migrations, version upgrades, or to create point-in-time snapshots of your Chef Infra Server.

## Install knife-ec-backup

```shell
gem install knife-ec-backup
```

## Common options

The following options are shared across all `knife ec` subcommands:

`--only-org <ORG>`
: Limit the operation to a single named organization.
  By default, all organizations are included.

`--concurrency <THREADS>`
: Maximum number of simultaneous API requests (default: 10).

`--skip-useracl`
: Skip downloading or restoring user ACLs.
  Required for Enterprise Chef 11.0.2 and earlier.

`--skip-version-check`
: Skip the Chef Infra Server version check and all autoconfigured options.

`--webui-key <KEYPATH>`
: Path to the WebUI private key.
  Defaults to reading from the secrets store, `/etc/opscode/webui_priv.pem`, or the Automate path.

`--secrets-file <PATH>`
: Path to `private-chef-secrets.json` (default: `/etc/opscode/private-chef-secrets.json`).

`--purge`
: Sync deletions from the backup source to the restore destination.

`--dry-run`
: Report what actions would be taken without performing any.

`--error-log-dir <PATH>`
: Directory where errors are logged during the operation.

## knife ec backup

```shell
knife ec backup <DIRECTORY>
```

Downloads all users, user ACLs, organizations, cookbooks, nodes, roles, environments, data bags, groups, and ACLs from a Chef Infra Server to a local directory.

### Common invocations

```shell
# Back up all organizations to a local directory
knife ec backup /var/backups/chef-server
```

```shell
# Back up a single organization
knife ec backup /var/backups/chef-server --only-org org-name
```

```shell
# Back up including user and key table data from PostgreSQL
knife ec backup /var/backups/chef-server --with-user-sql --with-key-sql \
  --sql-user opscode_chef --sql-password <PASSWORD>
```

```shell
# Back up and remove local users that no longer exist on the server
knife ec backup /var/backups/chef-server --purge
```

### Key flags

`--with-user-sql`
: Export user data directly from the PostgreSQL database.
  Required to correctly preserve user passwords and keys.

`--with-key-sql`
: Export rotated key data from the PostgreSQL `keys` table.
  Required for Chef Infra Server 12 and later when keys have been rotated.

`--skip-frozen-cookbook-status`
: Skip writing a `status.json` file for each cookbook.
  Use this when you don't want to persist a cookbook's frozen status across restores.

`--sql-host <HOSTNAME>`
: PostgreSQL hostname (default: `localhost`).

`--sql-port <PORT>`
: PostgreSQL port (default: `5432`).

`--sql-user <USERNAME>`
: PostgreSQL user for the `opscode_chef` database.

`--sql-password <PASSWORD>`
: PostgreSQL password.

### How knife ec backup works

`knife ec backup` downloads all users and user ACLs first, then iterates through every organization and downloads org-level objects using the Chef Infra Server REST API.
On Enterprise Chef 11 and earlier, pre-created unassigned organizations are skipped automatically.
The backup writes everything to a directory tree under `<DIRECTORY>/users/` and `<DIRECTORY>/organizations/<ORG>/`.
If `--with-user-sql` or `--with-key-sql` is set, the command connects directly to PostgreSQL and writes `key_dump.json` and `key_table_dump.json` alongside the backup.

## knife ec restore

```shell
knife ec restore <DIRECTORY>
```

Restores all users, organizations, cookbooks, and ACLs from a local backup directory to a Chef Infra Server.
Run this after `knife ec backup` to migrate data to a new server or recover from failure.

### Common invocations

```shell
# Restore all data from a backup directory
knife ec restore /var/backups/chef-server
```

```shell
# Restore a single organization only
knife ec restore /var/backups/chef-server --only-org org-name
```

```shell
# Restore without restoring users (for example, when users are managed by LDAP)
knife ec restore /var/backups/chef-server --skip-users
```

```shell
# Restore and overwrite pivotal's key (use with caution)
knife ec restore /var/backups/chef-server --overwrite-pivotal
```

### Key flags

`--skip-users`
: Skip restoring global users.
  Use this when users are managed externally, for example through LDAP or SAML.

`--overwrite-pivotal`
: Overwrite the `pivotal` superuser key during restore.
  After using this flag, all future API requests will fail until you update the private key on the server.
  By default, `pivotal` is skipped.

`--[no-]skip-user-ids`
: When enabled (default), reuses user IDs from the restore destination to avoid database conflicts.
  Pass `--no-skip-user-ids` to use IDs from the backup.

### How knife ec restore works

`knife ec restore` reads the directory structure written by `knife ec backup`.
It restores users first (skipping `pivotal` unless `--overwrite-pivotal` is set), then creates or updates each organization, restores open invitations, adds users to orgs, and uploads all org-level data.
If an organization already exists on the target server, the command updates it rather than failing.
User ACLs are restored last; pass `--skip-useracl` to skip this step if the target server runs Enterprise Chef 11.0.2 or earlier.

## knife ec import

```shell
knife ec import <DIRECTORY>
```

Imports objects from a backup directory into a Chef Infra Server.
`knife ec import` is similar to `knife ec restore` but designed for Automate-managed servers and environments where a tenant ID header is required.

### Common invocations

```shell
# Import all organizations from a backup directory
knife ec import /var/backups/chef-server
```

```shell
# Import with a tenant identifier header (required for some Automate deployments)
knife ec import /var/backups/chef-server --tenant-id tenant-uuid
```

### Key flags

`--tenant-id <TENANT_ID>`
: Adds an `X-Tenant-Id` header to all import requests.
  Required for Chef Automate deployments that use tenant-based routing.

## knife ec key export

```shell
knife ec key export [<USER_DATA_PATH>] [<KEY_DATA_PATH>]
```

Exports user and key table data directly from the Chef Infra Server PostgreSQL database to JSON files.
This command is invoked automatically by `knife ec backup --with-user-sql` and `--with-key-sql`, but you can also run it independently.

### Common invocations

```shell
# Export to default output files (key_dump.json and key_table_dump.json)
knife ec key export \
  --sql-user opscode_chef --sql-password <PASSWORD>
```

```shell
# Export to custom output file paths
knife ec key export user_table.json key_table.json \
  --sql-user opscode_chef --sql-password <PASSWORD>
```

```shell
# Export only the keys table, skipping the users table
knife ec key export --skip-users-table \
  --sql-user opscode_chef --sql-password <PASSWORD>
```

### Expected output

```console
knife ec key export --sql-user opscode_chef --sql-password secret
```

On success, the command writes `key_dump.json` and `key_table_dump.json` in the current directory (or the paths you provided) and exits silently.

### Key flags

`--skip-users-table`
: Skip exporting the `users` table.
  Use this when you only need rotated key data.

`--skip-keys-table`
: Skip exporting the `keys_by_name` table.
  Use this flag with Chef Infra Server 11, which doesn't have a keys table.

`--sql-host <HOSTNAME>`
: PostgreSQL hostname (default: `localhost`).

`--sql-port <PORT>`
: PostgreSQL port (default: `5432`).

`--sql-user <USERNAME>`
: PostgreSQL user for the `opscode_chef` database.

`--sql-password <PASSWORD>`
: PostgreSQL password.

### How knife ec key export works

`knife ec key export` connects directly to the Chef Infra Server PostgreSQL database using the Sequel gem.
It queries the `users` table (written to `key_dump.json` by default) and the `keys_by_name` table joined with `orgs` (written to `key_table_dump.json` by default).
If you pass custom file name arguments, those paths are used instead.
On Chef Infra Server 11, use `--skip-keys-table` to avoid a `PG::UndefinedTable` error.

## knife ec key import

```shell
knife ec key import [<USER_DATA_PATH>] [<KEY_DATA_PATH>]
```

Imports user and key table data from JSON files directly into the Chef Infra Server PostgreSQL database.
Run this after `knife ec restore` when you used `--with-user-sql` or `--with-key-sql` during backup.

### Common invocations

```shell
# Import from default file paths (key_dump.json and key_table_dump.json)
knife ec key import \
  --sql-user opscode_chef --sql-password <PASSWORD>
```

```shell
# Import from custom file paths
knife ec key import user_table.json key_table.json \
  --sql-user opscode_chef --sql-password <PASSWORD>
```

```shell
# Import only user data, skipping client key data
knife ec key import --users-only \
  --sql-user opscode_chef --sql-password <PASSWORD>
```

```shell
# Import only client key data, skipping user table
knife ec key import --clients-only \
  --sql-user opscode_chef --sql-password <PASSWORD>
```

### Key flags

`--[no-]skip-pivotal`
: Skip importing the `pivotal` user key (default: enabled).
  Pass `--no-skip-pivotal` to upload the pivotal key from the backup.

`--[no-]skip-user-ids`
: Reuse user IDs from the restore destination to avoid database conflicts (default: enabled).
  Pass `--no-skip-user-ids` to use IDs from the backup files.

`--users-only`
: Import only user data from the users table; skip client key data.

`--clients-only`
: Import only client key data; skip the users table.

`--skip-users-table`
: Skip importing the users table entirely.

`--skip-keys-table`
: Skip importing the `keys_by_name` table.

### How knife ec key import works

`knife ec key import` reads the JSON files written by `knife ec key export` and writes directly to the Chef Infra Server PostgreSQL database.
For clients, the organization ID is looked up dynamically by org name (with caching) because org IDs differ between source and destination servers.
Organizations must exist on the destination server before you run `knife ec key import`---run `knife ec restore` first.
