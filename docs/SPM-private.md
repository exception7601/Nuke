# Nuke

## Config Password login Xcode
Pata repositórios privados o login na api do GitHub e feito usando keychain, criando uma nova senha para permitir que o Xcode tenha acesso ao repositório .

```bash
security add-internet-password \
  -a 'exception7601' \
  -s 'api.github.com' \
  -w '*********************************' \
  -d 'api.github.com' \
  -r htps  \
  -T $(which xcodebuild) \
  -T $(which security) \
  -T "$(xcode-select -p | sed 's/\/Contents\/Developer//')" -U 

# clear SPM cache 
killall Xcode
rm -rf $HOME/Library/Caches/org.swift.swiftpm/
swift package resolve
```
## Using the .netrc 
Uma alternativa pro CI e criar um arquivo .netrc que uma arquivo padrão pra unix que permite configurar senhas para o login em terminais sites no arquivos.

```bash
cat << EOF  > $HOME/.netrc
machine api.github.com
login exception7601
password **********************
EOF
```

