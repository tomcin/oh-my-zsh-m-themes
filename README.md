oh-my-git-themes
================


## Use:

Edit de file ```.zshrc``` and add this line:

```bash
  antigen theme Mayccoll/oh-my-git-themes lio
```


---------------------------



## Installing ZSH

```bash
    $ sudo apt-get update

    $ sudo apt-get install -y \
        curl \
        vim \
        git \
        zsh
```

## Installing Oh-My-ZSH

```bash
    $ curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | bash
```

## Setting ZSH as the default shell (instead of bash)

```bash
    $ w=`which zsh` 
    $ h=`whoami` 
    $ sudo chsh -s $w $h
```

### Install antigen

```bash
    $ cd ~ && git clone https://github.com/zsh-users/antigen.git .antigen 
```

### Install antigen - Add 
    >>> ~/.zshrc

```bash
cat <<-EOF >> ~/.zshrc
source "$HOME/.antigen/antigen.zsh"

antigen bundle bundler
antigen bundle command-not-found
antigen bundle fabric
antigen bundle git
antigen bundle heroku
antigen bundle history
antigen bundle kennethreitz/autoenv
antigen bundle lein
antigen bundle node
antigen bundle npm
antigen bundle pip
antigen bundle python
antigen bundle rake
antigen bundle rsync
antigen bundle rvm
antigen bundle sprunge
antigen bundle vundle
antigen bundle zsh-users/zsh-completions src
antigen bundle zsh-users/zsh-syntax-highlighting
antigen-bundle arialdomartini/oh-my-git
antigen-bundle git
antigen-bundle vagrant
antigen-bundle zsh-users/zsh-history-substring-search
antigen-bundle zsh-users/zsh-syntax-highlighting

antigen theme Mayccoll/oh-my-git-themes lio

antigen-apply
EOF
```


## Fix Errors 
    $ rm ~/.antigen/repos/https-COLON--SLASH--SLASH-gi* -rf


