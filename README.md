# Nuke
Para distribuição do binário da biblioteca xcframewk no SPM em um github privado são necessários algum passos o primeiro e fazer o downloader da biblioteca ou compilar a xcframewk e depois fazer upload do zip nos assets da versão do projeto GitHub.

```bash
echo "12.1.6" > version
git commit -n "new Version 12.1.6"
git push --tags
zip -rX nuke-xcframeworks-ios-macos-platforms.zip Nuke.xcframework
```
(Obs o comando zip deve ser executado da pasta root )

Para fazer upload  da biblioteca pode ser feito usando uma a ferramenta o gh ou via web usando ci como por exemplo usando os comandos abaixo do swift pra gerar hash.

```bash
swift package compute-checksum nuke-xcframeworks-all-platforms/nuke-xcframeworks-ios-macos-platforms.zip

gh release create 12.1.6 nuke-xcframeworks-all-platforms/nuke-xcframeworks-ios-macos-platforms.zip --notes 'checksum `14844f2ae1bf3d62b7de3a95627a38ce03fcd0877e813e226b2de95259569ce9`'
```

Para poder usá-los no Xcode temos que pegar a url na API GitHub, por que a url padrão e um redirect que não e suportado pelo Xcode alem tem adicionar um .zip ao final da url que o Xcode não reconhece o arquivo em a extensão.

```bash
gh release view 12.1.6 --json assets

https://api.github.com/repos/exception7601/Nuke/releases/assets/124659544.zip

# test da URL
curl -L \
  -H "Accept: application/octet-stream" \
  -H "Authorization: Bearer  **********************" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  -o nuke.zip \
    https://api.github.com/repos/exception7601/Nuke/releases/assets/124659544.zip
```

Como o repositórios e privado para login na conta da GitHub umas das formas de configura o login e usando keychain, criando uma nova senha usando a configurações especificas do typo internet outra configuração e permitir que o Xcode tenha acesso.

```bash
security add-internet-password \
  -a 'exception7601' \
  -s 'api.github.com' \
  -w '*********************************' \
  -d 'api.github.com' \
  -r htps  \
  -T $(which xcodebuild) \
  -T $(which security) \
  -T "$(xcode-select -p | sed 's/\/Contents\/Developer//')" -U temp

# clear SPM cache 
rm -rf $HOME/.swiftpm/cache

```

Uma alternativa pro CI e criar um arquivo .netrc que uma arquivo padrão pra unix que permite configurar senhas para o login em terminais sites no arquivos.

```bash
cat << EOF  > $HOME/.netrc
machine api.github.com
login exception7601
password **********************
EOF
```
