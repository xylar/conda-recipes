# conda-recipes

# Buliding metapackages

Apparently `-c` cannot be passed to `metapackage` so in order to build
acme-unified and uvcdat metapackages I need to have the following in my 
`$HOME/.condarc`

```
channels:
- conda-forge
- uvcdat
- defaults
- acme_diags
- opengeostat
```

