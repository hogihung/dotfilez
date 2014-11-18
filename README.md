The following instructions assume that you don't already have the files .vimrc and .tmux.conf and that you don't already have a .vim and .vim/bundle directory.  If you do have any of these, please carefully review the steps below.

This is a very basic setup for supporting ViM and Tmux.

```
cd ~
mkdir .vim
mkdir .vim/bundle

git clone https://github.com/hogihung/dotfilez.git
cp ~/dotfilez/.vimrc ~/
cp ~/dotfilez/.tmux.conf ~/

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

cd ~/.vim/bundle
git clone https://github.com/altercation/vim-colors-solarized.git
```

Fire up vim and issue the command:  :PluginInstall
You should see the status of the Plugins being installed.  Once succesfull, you can exit vim.  

Go home and create sym-links:

```
cd
ln -s ~/dotfilez/.vimrc .vimrc
ln -s ~/dotfilez/.tmux.conf .tmux.conf
```

<br><hr>
For Mac OS X Users:
To enable copy and paste with Tmux and the OS X clipboard, follow these steps:

```
brew install reattach-to-user-namespace
```

Next, verify that you have the following in your ~/.tmux.conf file:
```
setw -g mode-keys vi
```

Lastly, update your ~/.tmux.conf file to include:
```
# Setup 'v' to begin selection as in Vim
bind-key -t vi-copy v begin-selection
bind-key -t vi-copy y copy-pipe "reattach-to-user-namespace pbcopy"

# Update default binding of `Enter` to also use copy-pipe
unbind -t vi-copy Enter
bind-key -t vi-copy Enter copy-pipe "reattach-to-user-namespace pbcopy"
```

For more information on copy/paste with Tmux see the following url:
http://robots.thoughtbot.com/tmux-copy-paste-on-os-x-a-better-future
