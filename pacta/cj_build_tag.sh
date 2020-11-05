#! /bin/bash

clones="PACTA_analysis create_interactive_report StressTestingModelDev pacta-data"
url="git@github.com:2DegreesInvesting/"
tag="${1:-latest}"

for repo in ${clones}
do
    remote="${url}${repo}.git"
    git clone -b master ${remote} --depth 1
    echo "--"
done

for repo in ${clones}
do
    echo "${repo} HEAD sha:"
    git -C "${repo}" rev-parse HEAD
    echo "--"
done

docker rmi 2dii_pacta
docker build ./ --tag 2dii_pacta:"${tag}"

for repo in ${clones}
do
    rm -rf "${repo}"
done

unzip pacta_web_template.zip

git clone -b master "${url}"user_results.git --depth 1
echo "user_results HEAD sha:"
git -C user_results rev-parse HEAD

rm -rf user_results/.git
rm user_results/.gitignore
rm user_results/.DS_Store
rm user_results/README.md
rm user_results/user_results.Rproj

cp -R user_results/ pacta_web/user_results/4/
rm -rf user_results

docker save 2dii_pacta | gzip > pacta_web/2dii_pacta.tar.gz

zip -r pacta_web.zip pacta_web -x ".DS_Store" -x "__MACOSX"

rm -rf pacta_web

exit 0
