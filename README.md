# Dotfiles

## Install

`cd` 到 dotfiles 目录下运行 `./setup.sh` 即可。部分软件需要后续的安装步骤，见下面。

### Homebrew

执行以下命令。`pp` 是设置代理环境变量的命令。

```bash
pp brew bundle --verbose
```

### NeoVim

需要安装 plugin ，运行 `nvim +PlugInstall` 。
