# ログインシェルとインタラクティブシェルの場合だけ読み込まれる。
# シェルスクリプトでは不要な場合に記述する。
# 
export PATH="$HOME/dotfiles/bin:$PATH"

export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
# For pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --no-rehash -)"


# For comporser (Laravel)
# export PATH=$PATH:~/.composer/vendor/bin


# For rbenv
eval "$(rbenv init --no-rehash -)";
export PATH="$HOME/.rbenv/shims:$PATH"



# aotoload設定一覧 (Zplugが入っている場合無効)
if [ -e /usr/local/opt/zplug ]; then
  # Zplug の有効化
  export ZPLUG_HOME=/usr/local/opt/zplug
  source $ZPLUG_HOME/init.zsh
  zplug "zsh-users/zsh-completions"
  zplug "zsh-users/zsh-syntax-highlighting"
  zplug "zsh-users/zsh-autosuggestions"
  zplug "mafredri/zsh-async"
  # プラグイン追加後、下記を実行する
  # zplug install
  zplug load
fi

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=230'

# utoload -Uz add-zsh-hook
# Color
# utoload -Uz colors && colors
# 補完関連
# utoload -U compinit && compinit

# Git のステータスを表示
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "|%F{yellow}staged%F{cyan}"
zstyle ':vcs_info:git:*' unstagedstr "|%F{red}unstaged%F{cyan}"
zstyle ':vcs_info:*' formats "%F{cyan}[%b%c%u]%f"
zstyle ':vcs_info:*' actionformats "%F{red}[%b|%a]%f"
precmd () { vcs_info }



# Theme configure
# eval `/usr/local/opt/coreutils/libexec/gnubin/dircolors ~/.dircolors-solarized/dircolors.ansi-dark`
eval $(gdircolors ~/dotfiles/zsh/bundle/color/dircolors-solarized)
eval $(dircolors ~/dotfiles/zsh/bundle/color/dircolors-solarized/dircolors.ansi-universal)

# 補完機能
bindkey "^[[Z" reverse-menu-complete

# complete 普通の補完関数; approximate ミススペルを訂正した上で補完を行う。; prefixカーソルの位置で補完を行う
zstyle ':completion:*' completer _complete _prefix #_approzimate

# 多部補完時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# タブを１回押すと、補完候補が表示され、さらにタブを押すことで、選択モードに入る
zstyle ':completion:*:default' menu select=2
if [ -n "$LS_COLORS" ]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# Printable 8bit
setopt print_eight_bit
setopt auto_cd
setopt auto_pushd
setopt correct

# プロンプト設定
my_prompt='[%m%#%n %~]%f'
PROMPT=%(?@'%F{cyan}${my_prompt} ${vcs_info_msg_0_}'$'\n''>> '@'%F{red}${my_prompt} ${vcs_info_msg_0_}'$'\n''>> ')
PROMPT2='>> '
SPROMPT="%F{red}Correct '%R' to '%r'?%f"$'\n''[nyae]>> '


alias relogin='exec $SHELL -l'
alias ls='gls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

# For git
alias g='git'
alias ga='git add'
alias gau='git add -u'
alias ga.='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gb='git branch'
alias gch='git checkout'
alias gd='git diff'
alias gs='git status'
alias gpull='git pull'
alias gpullre='git pull --rebase'
alias gpush='git push'
alias glog="git log --graph --all --pretty=format:'%C(yellow)%h%C(cyan)%d%Creset %s %C(white)- %an, %ar%Creset'"
alias g-reset-hard='git reset --hard HEAD'


# For PHP
alias xam='cd /Applications/XAMPP/xamppfiles/htdocs/php/'

# For Rails
alias be='bundle exec'

# For Note
alias note='cd ~/Documents/Note'

# グローバルIPアドレス確認
alias ipecho='curl ipecho.net/plain; echo'

# For vim
alias v='vim'
alias vim-utf8='vim -c ":e ++enc=utf8"'
alias vim-euc-jp='vim -c ":e ++enc=euc-jp"'
alias vim-shift-jis='vim -c ":e ++enc=shift_jis"'
# alias eclipse='open -a eclipse -data /User/tsk/Documents/workspace &'

# 拡張子に応じたコマンドを実行
alias -s txt='vim'
alias -s html='open'
alias -s rb='ruby'
alias -s py='python'
alias -s php='php -f'

# Dotfiles Config
alias vimrc='vim ~/.vimrc'
alias zshrc='vim ~/.zshrc'

# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history

# メモリに保存される履歴の件数
export HISTSIZE=1000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000

# 重複を記録しない
setopt hist_ignore_dups

# 開始と終了を記録
# setopt EXTENDED_HISTORY


# Google Search By Safari
goo() {
  local str opt
  if [ $# != 0 ]; then
    for i in $*; do
      str="$str${str:++}$i"
    done
    opt='search?num=100'
    opt="${opt}&q=${str}"
  fi
  open http://www.google.com/$opt
}

# Tmux起動
if [ $SHLVL = 1 ]; then
  tmux
else
  cat ~/dotfiles/screenfetch
fi

# ターミナル起動時に実行


# ZSHの起動した関数の時間計測 .zshenv参照
# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi
