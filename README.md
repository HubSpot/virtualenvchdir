## virtualenvchdir

You have a billion python projects, each with their own virtualenv. It's a pain to keep running `workon` while moving between
projects.

This can get quite annoying if you have tons of projects. To get around this, simply source the contained `virtualenvchdir.sh`
in your shell (either `bash` or `zsh`) and place virtualenv names in `.venv` files wherever you want to change into that
virtualenv.

### Install

    $ curl -L https://raw.github.com/HubSpot/virtualenvchdir/master/virtualenvchdir.sh > ~/.virtualenvchdir.sh
    $ echo ". ~/.virtualenvchdir.sh" >> ~/.bash_profile # (bash)
    $ echo ". ~/.virtualenvchdir.sh" >> ~/.zshrc # (zsh)

### Depencencies

This script depends on the execellent virtualenvwrapper project. See [http://www.doughellmann.com/projects/virtualenvwrapper/](http://www.doughellmann.com/projects/virtualenvwrapper/).

### Inspirations

This script was inspired by Justin Lilly's dotfiles: [https://github.com/justinlilly/jlilly-bashy-dotfiles/commit/04899f005397499e89da6d562b062545e70d7975](https://github.com/justinlilly/jlilly-bashy-dotfiles/commit/04899f005397499e89da6d562b062545e70d7975).

### License

The code is licensed under the MIT License
