# Description

The Dockerfile in this directory creates an image containing a freshly cloned
copies of PACTA_analysis and all the repositories it depends on.

The tree of the docker container looks like this:

```bash
/bound  # contents of PACTA_analysis
/pacta-data
/create_interactive_report
# ... more siblings of PACTA_analysis
```

# Usage

Note that PACTA_analysis and friends are not mounted but copied into the
conainer, so they will be frozen in the state they are when you build
the image.

# Usage

Run the build_with_tag.sh script from this directory, specifying a tag to assign to it. Ideally the tag should use semantic versioning, and should follow previously existing tags in the PACTA_analysis and friends repos.

```bash
./build_with_tag.sh 0.0.4
```

The script will:
- clone the repos locally, only copying the current version of the files
- remove any existing "2dii_pacta" images from your local docker system
- build a "2dii_pacta" docker image using the Dockerfile in this directory, which will
  - use 2dii/r-packages as a base
  - copy in the frshly cloned repos
  - make some necessary permissions changes
- use pacta_web_template.zip as a template to create new zip file named pacta_web.zip in this directory which will contain
  - an export of the freshly made docker image gzipped (2dii_pacta.tar.gz)
  - a few scripts and directories that contain sample data to facilitate testing the new image

If the build is succesful, one should test it with the test scripts, and if the tests are successful, load the image interactively and push the tags created for each of the PACTA_analysis and friends repos inside of the docker container.


# For the web


That shared docker image can be loaded into the new machine with...
```docker load --input 2dii_pacta.tar.gz```

The docker image can then be used as intended with a script such as...
```
working_dir="$(pwd)"/working_dir
user_results="$(pwd)"/user_results

docker run --rm -ti \
  --mount type=bind,source="$working_dir",target=/bound/working_dir \
  --mount type=bind,source="$user_results",target=/user_results \
  2dii_pacta \
  /bound/bin/run-r-scripts
```
where you set `working_dir` to the path to the directory that contains the user specific portfolio info on the server, and you set `user_results` to the path to the directory that contains the survey (and other) results that are relevant to the specific user on the server. Those directories will then be mounted inside of the docker containter in the appropriate locations.
