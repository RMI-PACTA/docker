#! /bin/bash

# Examples:
# # The tag is enforced
# build_with_tag 0.0.0.999
#
# # Optionally give the names of the repos as trailing arguments
# build_with_tag 0.0.0.999 PACTA_analysis StressTestingModelDev
#
# # With the help of pacta-find, you don't need to know the names
# # of pacta siblings -- it's enough to know the path to the parent.
# pacta_siblings="$(basename $(pacta-find ~/git))"
# ./build_with_tag.sh 0.0.0.999 "$pacta_siblings"
#
# # You may want to cleanup, particularly if the process ends early.
# git clean -dffx

red () {
    printf "\033[31m${1}\033[0m\n"
}

green () {
    printf "\033[32m${1}\033[0m\n"
}

user_results="user_results"
url="git@github.com:2DegreesInvesting/"
tag="$1"
repos="${@:2}"
if [ -z "$repos" ]
then
    repos="PACTA_analysis create_interactive_report StressTestingModelDev pacta-data"
fi

if [ -z "$tag" ]
then
    red "Please give a tag."
    exit 2
fi

parent="$(dirname $(which $0))"
if [ "$parent" == "." ]
then
    parent="$(pwd)"
fi

this_repo="$(dirname $parent)"
existing_tags="$(git -C $this_repo tag)"
for i in $existing_tags
do
    if [ "$i" == "$tag" ]
    then
        red "'$tag' already exists in $this_repo."
        red "Do you need 'git tag --delete $tag'?" && exit 1
    fi
done

# Clone
for repo in $repos
do
    remote="${url}${repo}.git"
    git clone -b master "$remote" --depth 1 || exit 2
    echo
done

repos_and_this_repo="$repos $this_repo"
echo $repos_and_this_repo
for repo in $repos_and_this_repo
do
    if [ -n "$tag" ]
    # Tag
    then
        green "Tagging $(basename $repo) with $tag"
        git -C "$repo" tag -a "$tag" -m "Release pacta $tag" HEAD
        if [[ "$?" -gt 0 ]]
        then
            red "Do you need 'git tag --delete $tag'?" && exit 1
        fi
        echo
    fi

    # Log
    green "$(git -C $repo log --pretty='%h %d <%an> (%cr)' | head -n 1)"
    echo
done

docker rmi --force $(docker images -q '2dii_pacta' | uniq)
echo

parent="$(dirname $(which $0))"
docker build --tag 2dii_pacta:"$tag" --tag 2dii_pacta:latest "$parent"
echo

for repo in $repos
do
    rm -rf "$repo"
done

image_tar_gz="${parent}/2dii_pacta.tar.gz"
green "Saving 2dii_pacta into $image_tar_gz ..."
docker save 2dii_pacta | gzip -q > "$image_tar_gz"
echo

green "Done :-)"
exit 0
