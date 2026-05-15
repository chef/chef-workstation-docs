+++
title = "knife-tidy plugin"

[menu]
  [menu.tools]
    title = "knife-tidy"
    identifier = "tools/knife/plugins/knife-tidy"
    parent = "tools/knife/plugins"
+++

<!--- cspell:words HELO helo --->

The `knife-tidy` plugin reports on and removes stale nodes, associated clients, ACLs, and unused cookbook versions from a Chef Infra Server.
It also cleans data-integrity issues from [`knife-ec-backup`](/tools/knife/plugins/knife_ec_backup/) directories before you restore them to a server.

## Install knife-tidy

You can install `knife-tidy` as a Ruby gem or as a Habitat package.

- Install `knife-tidy` as a Ruby gem:

  ```shell
  gem install knife-tidy
  ```

- Install `knife-tidy` as a Habitat package:

  ```bash
  hab pkg install chef/knife-tidy -bf
  ```

  {{< note >}}

  The `-bf` options binlink the `knife-tidy` binary into a system-wide directory in your `PATH` (for example, `/bin` or `/usr/local/bin`).
  You can then run `knife-tidy` directly from your shell.

  {{< /note >}}

## Syntax

If `knife-tidy` is installed as a Ruby gem or as a binlinked Chef Habitat package:

```shell
knife tidy <COMMAND> (options)
```

If you've installed `knife-tidy` as a Habitat package and didn't binlink it, execute it using the Habitat CLI and the full package name:

```shell
hab pkg exec chef/knife-ec-backup knife tidy <COMMAND> (options)
```

## Common options

The following option is shared across all `knife tidy` subcommands that connect to a Chef Infra Server:

`--orgs <ORG1,ORG2>`
: Limit the operation to the named organizations.
  By default, all organizations are included.

## knife tidy server report

```shell
knife tidy server report (options)
```

Scans a Chef Infra Server and writes JSON report files to the `reports/` directory in the current working directory.
The reports identify stale nodes and unused cookbook versions for each organization.

### Common invocations

```shell
# Report on all organizations using default thresholds
knife tidy server report [FLAGS]
```

```shell
# Report on specific organizations
knife tidy server report --orgs brewinc,acmeinc
```

```shell
# Treat nodes as stale after 50 days of inactivity, keep at least 2 cookbook versions
knife tidy server report --node-threshold 50 --keep-versions 2
```

### Output files

The command writes the following files to the `reports/` directory for each organization:

| File | Contents |
|---|---|
| `<ORG>_stale_nodes.json` | Nodes that haven't checked in within the threshold period |
| `<ORG>_cookbook_count.json` | Version count for each cookbook in the organization |
| `<ORG>_unused_cookbooks.json` | Cookbooks and versions not referenced in any node's run list |

### Key flags

`--node-threshold <NUM_DAYS>`
: Number of days since last check-in before a node is considered stale (default: 30).

`--keep-versions <MIN>`
: Minimum number of cookbook versions to keep per cookbook, even if they aren't in use (default: 1).

### How knife tidy server report works

`knife tidy server report` queries the Chef Infra Server search index and REST API to build a picture of which nodes are active and which cookbook versions are in use.
It cross-references node run lists, environment cookbook pins, and the full cookbook list on the server to identify unused versions.
If the search index is out of sync with the database, the command logs a warning and skips that organization---run `chef-server-ctl reindex` to resync.
Nodes running Chef Infra Client older than 12.3 generate an additional warning because their cookbook version data isn't factored into the unused-cookbooks calculation.
Run the report iteratively: after deleting stale nodes, more unused cookbooks may surface on the next run.

## knife tidy server clean

```shell
knife tidy server clean (options)
```

Reads the JSON report files produced by `knife tidy server report` and deletes stale nodes, associated clients, ACLs, and unused cookbooks from the Chef Infra Server.
Always take a current backup using [`knife ec backup`](/tools/knife/plugins/knife-ec-backup/) before running this command.

### Common invocations

```shell
# Clean all stale objects identified in reports, for all organizations
knife tidy server clean --backup-path /var/backups/chef-server
```

```shell
# Clean only stale nodes (skip unused cookbooks)
knife tidy server clean --backup-path /var/backups/chef-server --only-nodes
```

```shell
# Clean only unused cookbooks (skip stale nodes)
knife tidy server clean --backup-path /var/backups/chef-server --only-cookbooks
```

```shell
# Preview what would be deleted without making any changes
knife tidy server clean --backup-path /var/backups/chef-server --dry-run
```

```shell
# Clean specific organizations with increased concurrency
knife tidy server clean --backup-path /var/backups/chef-server \
  --orgs brewinc,acmeinc --concurrency 4
```

### Key flags

`--backup-path <PATH>`
: Path to the most recent `knife-ec-backup` backup directory.
  The command prompts interactively if this flag is omitted.

`--only-cookbooks`
: Delete only unused cookbooks.
  Can't be used together with `--only-nodes`.

`--only-nodes`
: Delete only stale nodes and their associated clients and ACLs.
  Can't be used together with `--only-cookbooks`.

`--dry-run`
: Print the deletions that would occur without performing any.

`--concurrency <THREADS>`
: Maximum number of simultaneous deletion requests (default: 1).

### How knife tidy server clean works

`knife tidy server clean` reads the `reports/` directory in the current working directory and determines the list of organizations from the report filenames.
It then iterates through each organization's `<ORG>_unused_cookbooks.json` and `<ORG>_stale_nodes.json` files and issues REST API delete calls for each item.
The command asks for confirmation before deleting unless `--unattended` is set.
If a `knife-tidy-server-warnings.txt` file was written by the report step, any warnings it contains are printed again before you confirm.
Specifying both `--only-cookbooks` and `--only-nodes` at the same time is an error and the command exits immediately.

## knife tidy backup clean

```shell
knife tidy backup clean (options)
```

Fixes data-integrity issues in a `knife-ec-backup` directory so the backup can be successfully restored with `knife ec restore`.
Run this command against a backup directory before attempting a restore operation.

### Common invocations

```shell
# Generate a boilerplate substitutions file
knife tidy backup clean --gen-gsub
```

```shell
# Clean a backup directory using the generated substitutions file
knife tidy backup clean --backup-path backups/ --gsub-file substitutions.json
```

```shell
# Clean a backup directory without any global substitutions
knife tidy backup clean --backup-path backups/
```

### Expected output

Running `--gen-gsub` creates a file called `substitutions.json` in the current directory:

```console
INFO: Creating boiler plate gsub file: 'substitutions.json'
```

When issues are repaired during a clean run, the command prints lines like:

```console
INFO: Validating org object for myorg
REPAIRING: org object for myorg contains extra/missing fields. Fixing that for you
REPAIRING: Correcting `name` in organizations/myorg/cookbooks/my-cookbook-1.0.0/metadata.rb
INFO: Generating new metadata.json for organizations/myorg/cookbooks/my-cookbook-1.0.0
** Finished **
```

If any issues can't be repaired automatically, the command writes them to `knife-tidy-actions-needed.txt` and prints a warning at the end:

```console
WARNING: ** Unrepairable Items **
Please see knife-tidy-actions-needed.txt
```

### Key flags

`--backup-path <PATH>`
: Path to the `knife-ec-backup` backup directory to clean.
  Required unless `--gen-gsub` is set.

`--gsub-file <PATH>`
: Path to a JSON substitutions file.
  If the file doesn't exist yet, generate one first with `--gen-gsub`.

`--gen-gsub`
: Generate a new boilerplate `substitutions.json` file in the current directory and exit.
  Edit this file before passing it to `--gsub-file`.

### Substitutions file format

The substitutions file maps glob patterns to search-and-replace rules applied to files in the backup.
To generate a starting point, run `knife tidy backup clean --gen-gsub`.
The following example shows the file structure:

```json
{
  "your-problem-descriptor": {
    "organizations/*/cookbooks/*/metadata.rb": [
      {
        "pattern": "^version .*GO_PIPELINE_LABEL",
        "replace": "version !COOKBOOK_VERSION!"
      }
    ]
  }
}
```

### How knife tidy backup clean works

`knife tidy backup clean` validates and repairs common issues that prevent `knife ec restore` from completing successfully.
Repairs include: fixing or regenerating corrupt org objects, correcting missing or mismatched cookbook `name` fields in `metadata.rb` and `metadata.json`, regenerating `metadata.json` from `metadata.rb`, removing self-dependencies in cookbook metadata, fixing null metadata values, fixing invalid platform constraint arrays, repairing invalid run list items in roles, ensuring clients are present in the clients group, and removing corrupt org invitations.
If a cookbook can't be loaded after repairs, it's moved to a `cookbooks.broken/` directory within the org.
Global text substitutions from `--gsub-file` are applied after the structural repairs.

## knife tidy notify

```shell
knife tidy notify (options)
```

Reads the JSON report files produced by `knife tidy server report` and emails a summary to each organization's admin users through an SMTP server.
Run this command from the directory containing your `reports/` folder.

### Common invocations

```shell
# Send reports using a local SMTP relay
knife tidy notify --smtp_server smtp.example.com --smtp_from admin@example.com
```

```shell
# Send reports with SMTP authentication and TLS
knife tidy notify \
  --smtp_server smtp.example.com \
  --smtp_port 587 \
  --smtp_from admin@example.com \
  --smtp_username myuser \
  --smtp_password <PASSWORD> \
  --smtp_use_tls
```

```shell
# Send reports for specific organizations only
knife tidy notify --orgs brewinc,acmeinc \
  --smtp_server smtp.example.com --smtp_from admin@example.com
```

### Key flags

`--smtp_server <SERVER_NAME>` / `-s`
: SMTP server hostname (default: `localhost`).

`--smtp_port <PORT>` / `-p`
: SMTP port (default: `25`).

`--smtp_from <ADDRESS>`
: From address for outgoing email reports.

`--smtp_username <USERNAME>` / `-u`
: SMTP authentication username.

`--smtp_password <PASSWORD>`
: SMTP authentication password.

`--smtp_use_tls` / `-t`
: Enable STARTTLS for the SMTP connection (default: `false`).

`--smtp_helo <HELO>` / `-h`
: SMTP HELO domain (default: `localhost`).

### How knife tidy notify works

`knife tidy notify` reads the `reports/` directory, identifies organizations by parsing report filenames, and queries the Chef Infra Server for the admin users of each organization.
It generates an HTML email with three tables---total cookbook versions, unused cookbooks, and stale nodes---and attaches the raw JSON report files.
The email is sent to all admin users of each organization.
The `pivotal` superuser is excluded from the recipient list.
If report files for an organization can't be parsed, the command prints an error and exits without sending.

## More information

- [knife-tidy GitHub repository](https://github.com/chef/knife-tidy/)
- [knife ec backup](/tools/knife/plugins/knife_ec_backup/)
