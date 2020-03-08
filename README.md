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

Elixir LSP 使用的本地 repo ，因此需要定期更新。进入 `~/workspace/op/elixir-ls` 并使用 git 拉取最新版，然后编译一个 release ：

```bash
mix deps.get
mix compile
mix elixir_ls.release
```

Release 的启动脚本的路径在 `nvim_coc_settings.json` 里指定了。
