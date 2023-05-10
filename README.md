# Dotfiles

## Install

执行 dotfiles 目录下的文件（当前目录可以不在 dotfiles 下）：

```bash
./bin/install.sh
```

这会先安装 dotfiles ，然后安装相邻目录下的 dotfiles-local 。

iTerm2 配置会被链接到 `~/.iterm2` 。不过还需要手动配置让 iTerm2 加载。在 iTerm2 中用 `Cmd + ,` 打开设置，在 `General > Preferences` 界面内，设置 `Load preferences from a custom folder or URL` ，选择配置文件目录即可。
