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
