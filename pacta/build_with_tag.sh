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

here="$(basename $(pwd))"
if [ ! "$here" == "pacta" ]
then
    red "Please run from 2diidockerrunner/pacta (not $(pwd))."
    exit 2
fi

clone_and_log () {
    for repo in $repos
    do
        remote="${url}${repo}.git"
        git clone -b master "$remote" --depth 1 || exit 2
        echo

        if [ -n "$tag" ]
        then
            green "Tagging as $tag"
            git -C "$repo" tag -a "$tag" -m "Release pacta $tag" HEAD || exit 2
            echo
        fi
        
        green "$(git -C $repo log --pretty='%h %d <%an> (%cr)' | head -n 1)"
        echo
    done
}

clone_and_log

docker rmi --force $(docker images -q '2dii_pacta' | uniq)
echo

docker build --tag 2dii_pacta:"$tag" --tag 2dii_pacta:latest .
echo

for repo in $repos
do
    rm -rf "$repo"
done

web_template_zip="pacta_web_template.zip"
green "Unzipping $web_template_zip ..."
unzip -q "$web_template_zip"
echo

image_tar_gz="pacta_web/2dii_pacta.tar.gz"
green "Saving 2dii_pacta into $image_tar_gz ..."
docker save 2dii_pacta | gzip -q > "$image_tar_gz"
echo

web_zip="pacta_web.zip"
green "Zipping $web_zip ..."
zip -rq "$web_zip" pacta_web -x ".DS_Store" -x "__MACOSX"

rm -rf pacta_web

green "Done :-)"
exit 0
