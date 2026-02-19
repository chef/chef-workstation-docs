+++
title = '{{ .File.ContentBaseName | humanize | title }}'
draft = false

[menu.<SECTION>]
title = "{{ .File.ContentBaseName | humanize | title }}"
identifier = "{{ .File.ContentBaseName | humanize | title }}"
parent = ""
weight = 10
+++


{{</* Run 'hugo new content path/to/new/page.md' to generate a new page. */>}}
