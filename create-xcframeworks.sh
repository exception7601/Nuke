NAME=nuke-xcframeworks-all-platforms.zip
REPO=kean/Nuke 
BUILD=$(date +%s) 
BUILD_COMMIT=$(git log --oneline --abbrev=16 --pretty=format:"%h" -1)
JSON_FILE="Carthage/NukeBinary.json"
# NEW_NAME=nuke-iOS-${BUILD_COMMIT}.zip
MY_REPO=exception7601/Nuke
VERSION=$(gh release list \
  --repo ${REPO} \
  --exclude-pre-releases \
  --limit 1 \
  --json tagName -q '.[0].tagName'
)

ORIGIN=$(pwd)
ROOT="$(pwd)/.build/xcframeworks"
MODULE_PATH="Nuke"
FRAMEWORK_NAME=Nuke
ARCHIVE_NAME=nuke
FRAMEWORK_PATH="Products/Library/Frameworks/Nuke.framework"
PLATAFORMS=("iOS" "iOS Simulator")

echo ${VERSION}

git submodule update --init --recursive
cd $MODULE_PATH
git fetch --tags

LATEST_TAG=$(git tag --sort=-creatordate | grep -v 'rc\|beta\|alpha' | head -n 1)
TAG_COMMIT=$(git rev-list -n 1 $LATEST_TAG)

set -e

echo "tag version: ${LATEST_TAG}"
git checkout -f $TAG_COMMIT


cd $ORIGIN 
# git add purchases-ios
# git commit -m "update submodule $LATEST_TAG"
# git push origin

rm -rf $ROOT

cd $MODULE_PATH

for PLATAFORM in "${PLATAFORMS[@]}"
do
  xcodebuild archive \
    -project "$FRAMEWORK_NAME.xcodeproj" \
    -scheme "$FRAMEWORK_NAME" \
    -destination "generic/platform=$PLATAFORM"\
    -archivePath "$ROOT/$ARCHIVE_NAME-$PLATAFORM.xcarchive" \
    MERGEABLE_LIBRARY=YES \
    CODE_SIGN_IDENTITY="Apple Development" \
    DEVELOPMENT_TEAM=PN8K78V28P \
    CODE_SIGN_STYLE=Automatic \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    DEBUG_INFORMATION_FORMAT=DWARF
done

xcodebuild -create-xcframework \
  -framework "$ROOT/$ARCHIVE_NAME-iOS.xcarchive/$FRAMEWORK_PATH" \
  -framework "$ROOT/$ARCHIVE_NAME-iOS Simulator.xcarchive/$FRAMEWORK_PATH" \
  -output "$ROOT/$FRAMEWORK_NAME.xcframework"

BUILD_COMMIT=$(git log --oneline --abbrev=16 --pretty=format:"%h" -1)
NEW_NAME=nuke-${BUILD_COMMIT}.zip
NAME_LIBRARY=".build/xcframeworks/${NEW_NAME}"

cd "$ROOT"

zip -rX "$NEW_NAME" "$FRAMEWORK_NAME.xcframework/"
# mv "$NEW_NAME" "$ORIGIN"
cd "$ORIGIN"

SUM=$(swift package compute-checksum ${NAME_LIBRARY} )
DOWNLOAD_URL="https://github.com/${MY_REPO}/releases/download/${VERSION}/${NEW_NAME}"

if [ ! -f $JSON_FILE ]; then
  echo "{}" > $JSON_FILE
fi

# Make Carthage
JSON_CARTHAGE="$(jq --arg version "${VERSION}" --arg url "${DOWNLOAD_URL}" '. + { ($version): $url }' $JSON_FILE)" 
echo $JSON_CARTHAGE > $JSON_FILE

PACKAGE=$(cat <<END
// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "Nuke",
  platforms: [.iOS(.v12)],
  products: [
    .library(
      name: "Nuke",
      targets: [
        "Nuke",
      ]
    ),
  ],

  targets: [
    .binaryTarget(
      name: "Nuke",
      url: "${DOWNLOAD_URL}",
      checksum: "${SUM}"
    )
  ]
)
END
)
echo "${VERSION}.${BUILD}" > version
echo "$PACKAGE" > Package.swift
git add Package.swift $JSON_FILE
git add version
git commit -m "new Version ${VERSION}"

# git push origin HEAD

# git commit -m "new Version ${VERSION}"
# git checkout -b release-v${VERSION}

git tag -s -a ${VERSION} -m "v${VERSION}"
git push origin HEAD --tags

gh release create "$VERSION" "$NAME_LIBRARY" --notes "checksum \`${SUM}\`"

NOTES=$(cat <<END
Carthage
\`\`\`
binary "https://raw.githubusercontent.com/${MY_REPO}/main/${JSON_FILE}"
\`\`\`

Install
\`\`\`
carthage bootstrap --use-xcframeworks
\`\`\`

SPM binaryTarget

\`\`\`
.binaryTarget(
  name: "Nuke",
  url: "${DOWNLOAD_URL}",
  checksum: "${SUM}"
)
\`\`\`
END
)

gh release edit ${VERSION} --notes  "${NOTES}"

echo "${NOTES}"
