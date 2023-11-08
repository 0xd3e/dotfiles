# GPG

This contains notes for tasks I do need to do every now and then, but I'm unable
to remember the exact steps when I need them.

I use a [Nitrokey](https://www.nitrokey.com) to store my PGP key. So this guide
contains specific instructions for that. My main secret key is not stored on my
machine.

## Renew Key

Since the secret key isn't stored on the machine, all operations that change the
keys need to have the secret key in place.

This is the listing of secret keys without the secret key in place. Note the `#`
after `sec`.

```bash
% gpg --list-secret-keys                                 
/path/to/.gnupg/pubring.kbx
-----------------------------------------
sec#  ed25519 2020-01-09 [C] [expired: 2023-01-09]
      <KEY ID>
uid           [ expired] Identity 1
uid           [ expired] Identity 2
...
```

Now import the secret key from wherever it is stored.

```bash
% gpg --import /path/to/private_key.asc 
```

Listing the secret keys should now look like this. Note that the `#` is gone.

```bash
% gpg --list-secret-keys                                                                
/path/to/.gnupg/pubring.kbx
-----------------------------------------
sec   ed25519 2020-01-09 [C] [expired: 2023-01-09]
      <KEY ID>
uid           [ expired] Identity 1
uid           [ expired] Identity 2
```

You can now edit the key and extend the expiration preferably by one year.

```bash
% gpg --edit-key <KEY ID>

gpg> key 0

gpg> expire

Changing expiration time for the primary key.
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 1y
Key expires at Wed Jan 24 11:01:57 2024 CET

Is this correct? (y/N) y

gpg> save
```

Export all keys to the location where you store the secret key.

```bash
% gpg \
  --export-secret-keys \
  --armor \
  --output /path/to/private_key_new.asc \
  <KEY ID>

% gpg \
  --export \
  --armor \
  --output /path/to/public_key_new.asc \
  <KEY ID>

% gpg \
  --export-secret-subkeys \
  --armor \
  --output /path/to/subkeys.private_new.asc \
  <KEY ID>
```

## GnuPG Migration

To copy PGP key to another machine, the subkeys and the trustdb entries need to
be exported. If the machine, that holds the keys is no longer available, import
them from the backup. If there is no backup - No backup? No mercy!

### Export

```bash
$ gpg \
  --export-secret-subkeys \
  --armor \
  --output /path/to/subkeys.private.asc \
  <KEY FINGERPRINT>

$ gpg --export-ownertrust > /path/to/otrust.txt
```

### Import

```bash
$ gpg --import /path/to/subkeys.private.asc
$ gpg --import-ownertrust /path/to/otrust.txt
```

Since the subkeys are stored on the Nitrokey, GnuPG will print something like
this after importing the subkeys.

```
To migrate 'secring.gpg', with each smartcard, run: gpg --card-status
```

Insert the Nitrokey and run `gpg --card-status` so that GnuPG picks them up.
