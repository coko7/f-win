# ✨ f-win

A handy script to "*fix*" Windows by installing decent CLIs and apps.

## 🛠️ Setup / Usage

Run it with one command:
```ps1
irm https://get.coko7.fr/fwin.ps1 | iex
```

## 🐛 Issues

### Cannot resolve 7-zip hostname

Scoop needs [7-zip](https://www.7-zip.org/) to install packages correctly.
Some organizations/countries tend to block 7-zip for whatever reasons. If you find yourself in this spot, you can try
to install 7-zip manually via copying MSI and then instructing scoop to use an external binary:
```ps1
scoop config use_external_7zip true
```
For more info: https://github.com/ScoopInstaller/Scoop/discussions/6553

### Problem with schannel

If you run into the following:
```txt
Updating Scoop...
fatal: unable to access 'https://github.com/ScoopInstaller/Scoop/': schannel: next InitializeSecurityContext failed: CRYPT_E_REVOCATION_OFFLINE (0x80092013) - The revocation function was unable to check revocation because the revocation server was offline.
```
You may want to switch the git SSL backend to OpenSSL:
```ps1
git config --global http.sslBackend openssl
```
Learn more here: https://stackoverflow.com/questions/45556189/git-the-revocation-function-was-unable-to-check-revocation-for-the-certificate
