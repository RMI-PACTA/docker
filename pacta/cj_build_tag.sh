git clone -b master git@github.com:2DegreesInvesting/PACTA_analysis.git --depth 1
git clone -b master git@github.com:2DegreesInvesting/create_interactive_report.git --depth 1
git clone -b master git@github.com:2DegreesInvesting/StressTestingModelDev.git --depth 1
git clone -b master git@github.com:2DegreesInvesting/pacta-data.git --depth 1

docker build ./ --tag 2dii_pacta:"${1:-latest}"

rm -rf PACTA_analysis
rm -rf create_interactive_report
rm -rf StressTestingModelDev
rm -rf pacta-data

unzip pacta_web_template.zip

docker save 2dii_pacta | gzip > pacta_web/2dii_pacta.tar.gz

zip -r pacta_web.zip pacta_web -x ".DS_Store" -x "__MACOSX"

rm -rf pacta_web
