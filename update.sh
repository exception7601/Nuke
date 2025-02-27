NAME=nuke-xcframeworks-all-platforms.zip
REPO=kean/Nuke 
BUILD=$(date +%s) 
BUILD_COMMIT=$(git log --oneline --abbrev=16 --pretty=format:"%h" -1)
JSON_FILE="Carthage/NukeBinary.json"
NEW_NAME=nuke-iOS-${BUILD_COMMIT}.zip
MY_REPO=exception7601/Nuke
VERSION=$(gh release list \
  --repo ${REPO} \
  --exclude-pre-releases \
  --limit 1 \
  --json tagName -q '.[0].tagName'
)

echo ${VERSION}

gh release download \
  ${VERSION} \
  --repo ${REPO} \
  -p ${NAME} \
  -D . \
  -O ${NAME} --clobber

unzip -o ${NAME}
zip -rX ${NEW_NAME} Nuke.xcframework

SUM=$(swift package compute-checksum ${NEW_NAME} )
DOWNLOAD_URL="https://github.com/${MY_REPO}/releases/download/${VERSION}/${NEW_NAME}"

if [ ! -f $JSON_FILE ]; then
  echo "{}" > $JSON_FILE
fi

# Make Carthage
JSON_CARTHAGE="$(jq --arg version "${VERSION}" --arg url "${DOWNLOAD_URL}" '. + { ($version): $url }' $JSON_FILE)" 
echo $JSON_CARTHAGE > $JSON_FILE

git add $JSON_FILE
git commit -m "new Version ${VERSION}"
# git push origin HEAD
# echo ${VERSION} > version
# git add version
# git commit -m "new Version ${VERSION}"
# git checkout -b release-v${VERSION}
git tag -s -a ${VERSION} -m "v${VERSION}"
git push origin HEAD --tags

gh release create ${VERSION} ${NEW_NAME} --notes "checksum \`${SUM}\`"

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
