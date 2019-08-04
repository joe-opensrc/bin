#### CLI 'web' search tool

##### Browse the web from the comfort of own your own command line!

It doesn't have to be the web specifically, it'll work with whatever the browsers support,
it's really just a fancy wrapper for parsing search queries ;)

Supported browsers (need them installed obvs ;)):

  w3m (default) \
  elinks \
  links2

Supported Engines are found in: ```~/bin/lks/engines.d```

Source: ```~/bin/lks/lks.complete``` \
for autocompletion of '-b' and '-e' args.

Make sure the folder is added to your PATH.

Typical Usage:

###### Google and w3m are defaults:
```bash 
  shell> lks some search terms
  shell> lks -b w3m -e google -a some search terms # wraps each search term in double-quotes
```

###### wiki search:
```bash
  shell> lks -e wiki interesting 
  shell> lks -b elinks -e wiki something else intersting
```


caveats:
  - many ;)
  - suffers from /path/to/app/app-itis
