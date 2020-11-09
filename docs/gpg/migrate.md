# GnuPG Migration

I use a [Nitrokey][nitrokey] to store my PGP key. So this guide contains
specific instructions for that. My main secret key is not stored on my machine.

To copy PGP key to another machine, the subkeys and the trustdb entries need to
be exported. If the machine, that holds the keys is no longer available, import
them from the backup. If there is no backup - No backup? No mercy!

## Export

```bash
$ gpg --export-secret-subkeys --armor --output /path/to/subkeys.private.asc <KEY FINGERPRINT>
$ gpg --export-ownertrust > /path/to/otrust.txt
```

## Import

```bash
$ gpg --import /path/to/subkeys.private.asc
$ gpg --import-ownertrust /path/to/otrust.txt
```

Since the subkeys are stored on the Nitrokey, GnuPG will print something like
that after importing the subkeys.

```
To migrate 'secring.gpg', with each smartcard, run: gpg --card-status
```

Insert the Nitrokey and run `gpg --card-status` so that GnuPG picks them up.

[nitrokey]: https://www.nitrokey.com
