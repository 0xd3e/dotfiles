# Tower

[Tower][tower] needs a special environment file to work with the SSH
configuration. In fact, it needs to know the `SSH_AUTH_SOCK` environment
variable, so that the SSH authentication with Git is working.

The [documentation][tower-docs-environment] provides some details for that.

[tower]: https://www.git-tower.com
[tower-docs-environment]: https://www.git-tower.com/help/guides/integration/environment/mac
