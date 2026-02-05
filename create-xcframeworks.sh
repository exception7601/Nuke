#!/bin/sh

set -e

# NAME=nuke-xcframeworks-all-platforms.zip
REPO=kean/Nuke 
BUILD=$(date +%s) 
BUILD_COMMIT=$(git log --oneline --abbrev=16 --pretty=format:"%h" -1)
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

echo "${VERSION}"

git submodule update --init --recursive

git -C "$MODULE_PATH" fetch --tags

LATEST_TAG=$(git -C "$MODULE_PATH" tag --sort=-creatordate | grep -v 'rc\|beta\|alpha' | head -n 1)
TAG_COMMIT=$(git -C "$MODULE_PATH" rev-list -n 1 "$LATEST_TAG")

echo "tag version: ${LATEST_TAG}"
git -C "$MODULE_PATH" checkout -f "$TAG_COMMIT"

# git add purchases-ios
# git commit -m "update submodule $LATEST_TAG"
# git push origin

rm -rf "$ROOT"

for PLATAFORM in "${PLATAFORMS[@]}"
do
  xcodebuild archive \
    -project "$MODULE_PATH/$FRAMEWORK_NAME.xcodeproj" \
    -scheme "$FRAMEWORK_NAME" \
    -destination "generic/platform=$PLATAFORM"\
    -archivePath "$ROOT/$ARCHIVE_NAME-$PLATAFORM.xcarchive" \
    MERGEABLE_LIBRARY=YES \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    DEBUG_INFORMATION_FORMAT=DWARF \
    MACH_O_TYPE=staticlib
done

xcodebuild -create-xcframework \
  -framework "$ROOT/$ARCHIVE_NAME-iOS.xcarchive/$FRAMEWORK_PATH" \
  -framework "$ROOT/$ARCHIVE_NAME-iOS Simulator.xcarchive/$FRAMEWORK_PATH" \
  -output "$ROOT/$FRAMEWORK_NAME.xcframework"

BUILD_COMMIT=$(git -C "$MODULE_PATH" log --oneline --abbrev=16 --pretty=format:"%h" -1)
NEW_NAME=nuke-${BUILD_COMMIT}.zip
NAME_LIBRARY=".build/xcframeworks/${NEW_NAME}"

cd "$ROOT"
zip -rX "$NEW_NAME" "$FRAMEWORK_NAME.xcframework/"
# mv "$NEW_NAME" "$ORIGIN"
cd "$ORIGIN"

DOWNLOAD_URL="https://github.com/${MY_REPO}/releases/download/${VERSION}/${NEW_NAME}"
SUM=$(swift package compute-checksum "$NAME_LIBRARY")

# Update Package.swift
sed -i '' "s|url: \".*\"|url: \"${DOWNLOAD_URL}\"|g" Package.swift
sed -i '' "s|checksum: \".*\"|checksum: \"${SUM}\"|g" Package.swift

echo "${VERSION}.${BUILD}" > version

# echo "$PACKAGE" > Package.swift
git add Package.swift
git add version
git commit -m "new Version ${VERSION}"

# git push origin HEAD
# git commit -m "new Version ${VERSION}"
# git checkout -b release-v${VERSION}

git tag -s -a "${VERSION}" -m "v${VERSION}"
git push origin HEAD --tags


NOTES=$(cat <<END
SPM binaryTarget

\`\`\`swift
.binaryTarget(
    name: "Nuke",
    url: "${DOWNLOAD_URL}",
    checksum: "${SUM}"
)
\`\`\`
END
)

gh release create "$VERSION" "$NAME_LIBRARY" --notes "$NOTES"

echo "${NOTES}"
