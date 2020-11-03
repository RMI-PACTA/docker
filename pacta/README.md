# Description

The Dockerfile in this directory creates an image containing a copy of your
local repository PACTA_analysis and all the repositories it depends on.

The tree of the docker container looks like this:

```bash
/bound  # contents of PACTA_analysis
/pacta-data
/create_interactive_report
# ... more siblings of PACTA_analysis
```

# Usage

Before you build build this image you may want to pull from
GitHub the latest changes of PACTA_analysis and friends (see
<https://github.com/maurolepore/bin/blob/master/pacta-sync>).

`build-tag` helps you build this image. You must run it from inside this
directory:

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

Once you start the container, change directory into /bound -- which is
the name of PACTA_analysis in the container.

```bash
cd /bound
```

Now you may run the web-tool scripts only:

```bash
./bin/run-web-tool-from-local-copy
```

Note that PACTA_analysis and friends are not mounted but copied into the
conainer, so they will be frozen in the state they are when you build
the image.

