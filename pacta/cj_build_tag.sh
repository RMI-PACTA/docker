git clone -b master git@github.com:2DegreesInvesting/PACTA_analysis.git --depth 1
git clone -b master git@github.com:2DegreesInvesting/create_interactive_report.git --depth 1
git clone -b master git@github.com:2DegreesInvesting/StressTestingModelDev.git --depth 1
git clone -b master git@github.com:2DegreesInvesting/pacta-data.git --depth 1

echo "PACTA_analysis HEAD sha:"
git -C PACTA_analysis rev-parse HEAD
echo "create_interactive_report HEAD sha:"
git -C create_interactive_report rev-parse HEAD
echo "StressTestingModelDev HEAD sha:"
git -C StressTestingModelDev rev-parse HEAD
echo "pacta-data HEAD sha:"
git -C pacta-data rev-parse HEAD

docker rmi 2dii_pacta
docker build ./ --tag 2dii_pacta:"${1:-latest}"

rm -rf PACTA_analysis
rm -rf create_interactive_report
rm -rf StressTestingModelDev
rm -rf pacta-data

unzip pacta_web_template.zip

git clone -b master git@github.com:2DegreesInvesting/user_results.git --depth 1
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
