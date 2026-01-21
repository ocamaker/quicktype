#!/usr/bin/env bash

set -e

./script/patch-npm-version.ts

VERSION=$(jq -r '.version' package.json )
npm version $VERSION --workspaces --force

# Publish core
pushd packages/quicktype-core
npm publish --access public
popd

# Publish typescript input
pushd packages/quicktype-typescript-input
jq --arg version $VERSION \
    '.dependencies."@ocamaker/quicktype-core" = $version' \
    package.json > package.1.json
mv package.1.json package.json
npm publish --access public
popd

# Publish graphql input
pushd packages/quicktype-graphql-input
jq --arg version $VERSION \
    '.dependencies."@ocamaker/quicktype-core" = $version' \
    package.json > package.1.json
mv package.1.json package.json
npm publish --access public
popd

# Publish quicktype
jq --arg version $VERSION \
    '.dependencies."@ocamaker/quicktype-core" = $version | .dependencies."@ocamaker/quicktype-graphql-input" = $version | .dependencies."@ocamaker/quicktype-typescript-input" = $version' \
    package.json > package.1.json
mv package.1.json package.json
npm publish --access public

# Commit the version bump
git add .
git commit -m "Publish version $VERSION [skip ci]"
git push
git tag "v$VERSION"
git push origin main --tags



# SKIPPING -> Won't Publish vscode extension
# pushd packages/quicktype-vscode
# npm run pub
# popd
