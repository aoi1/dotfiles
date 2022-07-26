# dotfiles
dotfiles

## Mac

1. install brew
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/a001546/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

2. install peco
```
brew install peco
```

3. install neovim
```
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
tar xzf nvim-macos.tar.gz
sudo mv nvim-macos/bin/nvim /usr/local/bin/
```

4. run dotfileLink.sh
```
./dotfileLink.sh
```

`.config`がうまくリンクされない場合は既に存在する`.config`を別の場所にmoveしてください。


ファイル配置前に以下のインストールをしてください

- dein.vim
  - https://github.com/Shougo/dein.vim
  - インストール方法は上記リポジトリのreadmeに書かれています
