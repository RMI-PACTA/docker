# Description

The Dockerfile in this directory creates an image containing a copy of your
local repository PACTA_analysis and all the repositories it depends on. For
it to work, all those repositories should be siblings (i.e. share the same
parent directory), and they should also be siblings of this repository --
2diidockerrunner.

Before you build build this image you may want to pull from
GitHub the latest changes of PACTA_analysis and friends (see
https://github.com/maurolepore/bin/blob/master/pacta-sync).

# Usage

Build this image from this directory:

```bash
# Build 2dii/pacta:0.0.1
./build-tag 0.0.1

# Build 2dii/pacta:latest (default)
./build-tag
```

Run a container from anywhere:

```bash
# Run a container from 2dii/pacta:latest and destroy it on exit (--rm)
docker run --rm -ti 2dii/pacta:latest /bin/bash
```
