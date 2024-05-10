NAME=nuke-xcframeworks-all-platforms.zip
NEW_NAME=nuke-xcframeworks.zip
REPO=kean/Nuke 

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

unzip ${NAME}
zip -rX ${NEW_NAME} Nuke.xcframework

SUM=$(swift package compute-checksum ${NEW_NAME} )

echo ${VERSION} > version
git add version
git commit -m "new Version ${VERSION}"
git push --tags

gh release create ${VERSION} nuke-xcframeworks.zip --notes "checksum \`${SUM}\`"

URL=$(gh release view ${VERSION} \
  --repo exception7601/Nuke \
  --json assets \
  -q '.assets[0].apiUrl'
)

echo "${URL}.zip"
echo ${SUM}
# gh release create ${VERSION} ${NAME}  --notes  "checksum `${SUM}`'"
